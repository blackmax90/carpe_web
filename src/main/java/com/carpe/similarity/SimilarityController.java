package com.carpe.similarity;

import java.io.BufferedReader;
import java.io.File;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.codec.binary.Base64;
import org.apache.spark.api.java.JavaRDD;
import org.apache.spark.ml.feature.CountVectorizer;
import org.apache.spark.ml.feature.CountVectorizerModel;
import org.apache.spark.mllib.linalg.DenseVector;
import org.apache.spark.mllib.linalg.Vector;
import org.apache.spark.mllib.linalg.Vectors;
import org.apache.spark.sql.Dataset;
import org.apache.spark.sql.Row;
import org.apache.spark.sql.RowFactory;
import org.apache.spark.sql.SparkSession;
import org.apache.spark.sql.types.ArrayType;
import org.apache.spark.sql.types.DataTypes;
import org.apache.spark.sql.types.Metadata;
import org.apache.spark.sql.types.StructField;
import org.apache.spark.sql.types.StructType;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.carpe.common.CarpeConfig;
import com.carpe.common.Consts;
import com.carpe.common.search.SearchService;

import io.searchbox.core.SearchResult;
import io.searchbox.core.SearchResult.Hit;

@Controller
public class SimilarityController {
	
	@Inject
	private SearchService service;
	
	private static double getCosineSimilarity(Vector v1, Vector v2) {
        return v1.dot(v2) / (Vectors.norm(v1, 2) * (Vectors.norm(v2, 2)));
    }
	
	@RequestMapping(value = "/similarity.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView similarity(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("carpe/similarity/similarity");

		return mav;
	}

	@RequestMapping(value = "/similarity_proc.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView similarityProc(@RequestParam HashMap<String, String> map, @RequestParam(value="path[]") String[] arrPath
      , HttpSession session, HttpServletRequest requst, Model model) throws Exception {
	    ModelAndView mav = new ModelAndView();
	    mav.setViewName("jsonView");
	    int ret = 0;
	    String msg = "";
	    String target = map.get("target");
	    System.out.println("target : " + target);
	    String target_name = "";
	    
		String caseid = (String) session.getAttribute(Consts.SESSION_CASE_ID);
		String evdid = (String) session.getAttribute(Consts.SESSION_EVDNC_ID);

	    Map<String, Object> paramMap = new HashMap<String, Object>();

		try {
			paramMap.put("searchTarget", target);
		} catch (Exception e) {
			e.printStackTrace();
			mav.addObject("totalcount", 0);
			return mav;
		}

		// target
		SearchResult searchResult = service.search_content(paramMap);
		if (searchResult == null) {
			mav.addObject("msg", "result is null.");
			mav.setStatus(HttpStatus.INTERNAL_SERVER_ERROR);
			return mav;
		}

		if (!searchResult.isSucceeded()) {
			mav.addObject("msg", "search fail.");
			mav.setStatus(HttpStatus.INTERNAL_SERVER_ERROR);
			return mav;
		}

		long totalCnt = 0;
		totalCnt = searchResult.getTotal();
		System.out.println("Total Count: " + totalCnt);
		List<Hit<Map<String, Object>, Void>> thehits = (List) searchResult.getHits(Map.class);
		List<String> sourceSplitted;
		Row sourceRow = null;
		
		for (Hit<Map<String, Object>, Void> hit : thehits) {
			String content = "";
			if (hit.source.get("content") != null) {
				content = hit.source.get("content").toString();
				sourceSplitted = Arrays.asList(content.toString().split("\n| "));
				sourceRow = RowFactory.create(sourceSplitted);	
			}
			if (hit.source.get("name") != null) {
				target_name = hit.source.get("name").toString();
			}
		}
		if (sourceRow == null) {
			return mav;
		}
		// others
		List<Map> list = new ArrayList<Map>();
        StructType schema = new StructType(new StructField[] {
                new StructField("words", new ArrayType(DataTypes.StringType, true), false, Metadata.empty()) });
        
        SparkSession spark = SparkSession.builder()
                .appName("")
                .config("spark.master", "local")
                .getOrCreate();

            spark.sparkContext().setLogLevel("ERROR");
        
        // List<Double> results = new ArrayList<Double>(arrPath.length);
        List<Map<String, Object>> results = new ArrayList<>();
		for(String path : arrPath) {
			String name = "";
			double result = 0.0;
			paramMap.clear();
			try {
				paramMap.put("searchTarget", path);
			} catch (Exception e) {
				e.printStackTrace();
				mav.addObject("totalcount", 0);
				return mav;
			}
			searchResult = service.search_content(paramMap);
			if (searchResult == null) {
				mav.addObject("msg", "result is null.");
				mav.setStatus(HttpStatus.INTERNAL_SERVER_ERROR);
				return mav;
			}
			if (!searchResult.isSucceeded()) {
				mav.addObject("msg", "search fail.");
				mav.setStatus(HttpStatus.INTERNAL_SERVER_ERROR);
				return mav;
			}
			totalCnt = 0;
			totalCnt = searchResult.getTotal();
			
			
			thehits.clear();
			thehits = (List) searchResult.getHits(Map.class);
			
			for (Hit<Map<String, Object>, Void> hit : thehits) {
				String content = "";

				if (hit.source.get("content") != null) {
					if (hit.source.get("name") != null) {
						name = hit.source.get("name").toString();
					}
					
					content = hit.source.get("content").toString();
					List<String> destSplitted = Arrays.asList(content.toString().split("\n| "));
					
					List<Row> rowsForMatrix = new ArrayList<Row>();
			        rowsForMatrix.add(sourceRow);
			        rowsForMatrix.add(RowFactory.create(destSplitted));
			        Dataset<Row> dataSet = spark.createDataFrame(rowsForMatrix, schema);
			        
			        CountVectorizerModel CVM = new CountVectorizer()
			                .setInputCol("words")
			                .setOutputCol("features")
			                .setVocabSize(10000)
			                .setMinDF(1)
			                .fit(dataSet);
			            Dataset<Row> cvmResult = CVM.transform(dataSet);

			            JavaRDD<DenseVector> denseVectors = cvmResult
			                .select("features")
			                .javaRDD()
			                .map((row) -> Vectors.parse(row.get(0).toString()).toDense());
			            // dest 문서 하나씩 비교
			            result = getCosineSimilarity(denseVectors.first(), denseVectors.collect().get(1));
			            
				}

			}
			System.out.println(result);
			Map<String, Object> rsMap = new HashMap<>();
	        rsMap.put("name", name);
	        rsMap.put("path", path);
	        rsMap.put("value", result);
	        results.add(rsMap);
			
		}

		spark.stop();
		
	    mav.addObject("targetName", target_name);
	    mav.addObject("targetPath", target);
	    mav.addObject("result", results);
	    mav.addObject("ret", ret);
	    mav.addObject("msg", msg);
	    
	    return mav;
  }
}
