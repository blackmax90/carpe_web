package com.carpe.fileupload;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.UUID;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.method.annotation.SseEmitter;

import com.carpe.common.CarpeConfig;
import com.carpe.common.CommonUtil;
import com.carpe.common.Consts;
import com.carpe.evdnc.EvdncService;
import com.rabbitmq.client.Channel;
import com.rabbitmq.client.Connection;
import com.rabbitmq.client.ConnectionFactory;

import net.sf.json.JSONObject;

@Controller
public class FileUploadController implements FileCopyStatus {
	@Inject
	private EvdncService evdncService;

	private Map<String, SseEmitter> sseList = new HashMap<String, SseEmitter>();
	private Map<String, Map> paramList = new HashMap<>();
	private List<String> completeList = new ArrayList<String>();
	
	private static final String UPTYPE_EVDNC = "evdnc";
	
	public void onDone(String evdId, String ticket) {
		completeList.add(ticket);

		if (sseList.containsKey(ticket)) {
			JSONObject json = new JSONObject();
			SseEmitter emitter = sseList.get(ticket);

			try {
				Map<String, Object> paramMap = paramList.get(ticket);
				
				if (paramMap == null || CommonUtil.empty(paramMap.get("upload_type"))) {
					json.put("id", "error");
					json.put("msg", "Add Evidence failed!");
					emitter.send(json.toString());
					return;
				}

				if (paramMap.get("upload_type").equals(UPTYPE_EVDNC)) {
					evdncService.insertEvdnc(paramMap);

					String caseId = paramMap.get("case_id") + "";
					String mqMsg = "{'req_id':'1', 'req_type':'analyze', 'case_id':'" + caseId + "', 'evd_id':'" + evdId + "', 'options':'vss'}";

					ConnectionFactory factory = new ConnectionFactory();
					factory.setUsername(CarpeConfig.getMqId());
					factory.setPassword(CarpeConfig.getMqPw());
					factory.setHost(CarpeConfig.getMqServer());
					factory.setVirtualHost(CarpeConfig.getMqVhost());
					Connection connection = factory.newConnection();
					Channel channel = connection.createChannel();

					channel.queueDeclare(CarpeConfig.getMqQueue(), true, false, false, null);
					channel.basicPublish("", CarpeConfig.getMqQueue(), null, mqMsg.getBytes("UTF-8"));

					channel.close();
					connection.close();

					json.put("msg", "Add Evidence Complete!");
				}

				json.put("id", "done");

				emitter.send(json.toString());
			} catch (Exception e) {
				e.printStackTrace();

				json.put("id", "error");
				json.put("msg", "Add Evidence failed!");
				
				try {
					emitter.send(json.toString());
				} catch (Exception e2) {
					e2.printStackTrace();
				}
			} finally {
				sseList.remove(ticket);
				paramList.remove(ticket);
				emitter.complete();
			}
		}
	}

	public void onError(String evdId, String ticket, Exception e) {
		completeList.add(ticket);

		if (sseList.containsKey(ticket)) {
			SseEmitter emitter = sseList.get(ticket);

			try {
				JSONObject json = new JSONObject();
				json.put("id", "error");
				json.put("msg", e.getMessage());

				emitter.send(json.toString());
			} catch (Exception innerEx) {
				innerEx.printStackTrace();
			} finally {
				sseList.remove(ticket);
				emitter.complete();
			}
		}
	}

	public void onProgress(String ticket, long currentCompletedSize, long totalSize) {
		if (sseList.containsKey(ticket)) {
			SseEmitter emitter = sseList.get(ticket);

			try {
				JSONObject json = new JSONObject();
				json.put("id", "ing");
				json.put("current_completed_size", currentCompletedSize);
				json.put("total_size", totalSize);
				
				emitter.send(json.toString());
			} catch (Exception innerEx) {
				innerEx.printStackTrace();
			}
		}
	}

	@RequestMapping(value = "/file_upload_view.do", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView fileUploadView(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model model) throws Exception {
		ModelAndView mav = new ModelAndView();

		mav.setViewName("carpe/fileupload_progress_ajax");
		//mav.setViewName("carpe/fileupload");
		return mav;
	}

	@RequestMapping(value = "/file_upload.do", method = { RequestMethod.POST })
	public ResponseEntity<Object> fileUpload(Locale locale, @RequestParam HashMap<String, String> map, @RequestParam("file1") MultipartFile file, Model model) throws Exception {

		System.out.println("\n\n\n------");
		System.out.println(file.getOriginalFilename());
		System.out.println(file.getName());
		System.out.println(file.getSize());

		if (file.getOriginalFilename().isEmpty()) {
			return new ResponseEntity<>("Empty file name.", HttpStatus.BAD_REQUEST);
		}

		File destFile = new File("/temp", file.getOriginalFilename());
		file.transferTo(destFile);

		return new ResponseEntity<>("File Uploaded Successfully.", HttpStatus.OK);
	}

	@RequestMapping(value = "/add_evdnc_server_file.do", method = { RequestMethod.POST })
	public ModelAndView addEvdncServerFile(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model modell) throws Exception {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("jsonView");
		String src = CarpeConfig.getEvdncImagePath();
		String selFile = map.get("path");
		
		src += "/" + selFile;
		
		File f = new File(src);
		
		if (f.exists() == false) {
			mav.addObject("msg", selFile + " file not found.");
		  mav.setStatus(HttpStatus.BAD_REQUEST);
			return mav;
		}
		
		String ticket = UUID.randomUUID().toString().replace("-", "");
		String evdncId = CarpeConfig.getEvdncCode() + ticket;
		String caseId = (String) session.getAttribute(Consts.SESSION_CASE_ID) + "";

		String physicalDir = String.format("%s/%s/%s", CarpeConfig.getEvdncBasePath(), caseId, evdncId);
		(new File(physicalDir)).mkdirs();

		String evdncFile = String.format("%s/%s/%s", caseId, evdncId, f.getName());
		String evdncTmpPath = String.format("%s/%s", caseId, evdncId);

		String evdncName = map.get("newEvdncName");
		String evdncMainType = "image";
		String evdncSubType = map.get("newEvdncSubType");
		String timezone = "UTC+9";
		String dest = String.format("%s/%s", physicalDir, f.getName());

		Map<String, Object> paramMap = new HashMap<String, Object>();

		paramMap.put("upload_type", UPTYPE_EVDNC);
		paramMap.put("id", evdncId);
		paramMap.put("path", evdncFile);
		paramMap.put("tmp_path", evdncTmpPath);
		paramMap.put("name", evdncName);
		paramMap.put("main_type", evdncMainType);
		paramMap.put("sub_type", evdncSubType);
		paramMap.put("case_id", caseId);
		paramMap.put("timezone", timezone);

		paramList.put(ticket, paramMap);

		FileCopyWorker fileCopyWorker = new FileCopyWorker(evdncId, ticket, src, dest, this);
		fileCopyWorker.startup();

		mav.addObject("msg", ticket);
		mav.setStatus(HttpStatus.OK);

		return mav;
	}

	@RequestMapping(value = "/server_file_event.do", method = { RequestMethod.GET })
	public SseEmitter serverFileEvent(@RequestParam HashMap<String, String> map, HttpSession session, HttpServletRequest requst, Model modell) throws Exception {
		String ticket = map.get("ticket");
		
		SseEmitter emitter = new SseEmitter(15000L);
		emitter.onCompletion(() -> {
			synchronized (this) {
				sseList.remove(ticket);
			}
		});

		emitter.onTimeout(() -> {
			sseList.remove(ticket);
			emitter.complete();
		});

		if (completeList.contains(ticket)) {
			try {
				JSONObject json = new JSONObject();
				json.put("id", "done");

				emitter.send(json.toString());
			} catch (Exception innerEx) {
				innerEx.printStackTrace();
			} finally {
				completeList.add(ticket);
				emitter.complete();
			}
		}

		sseList.put(ticket, emitter);

		return emitter;
	}

}