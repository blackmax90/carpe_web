package com.carpe.common.search;

import java.util.AbstractMap;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import io.searchbox.client.JestClient;
import io.searchbox.core.Search;
import io.searchbox.core.SearchResult;

@Service
public class SearchService {

	@Inject
	private JestClient jestClient;

	public SearchResult search(Map<String, Object> paramMap) throws Exception {
		boolean inFileName = (boolean) paramMap.get("inFileName");
		boolean inContent = (boolean) paramMap.get("inContent");

		List<String> fieldList = new ArrayList<String>();
		if (inFileName) {
			fieldList.add("name");
		}
		if (inContent) {
			fieldList.add("content");
		}

		if (fieldList.size() < 1) {
			fieldList.add("name");
			fieldList.add("content");
		}

		String queryString = (String) paramMap.get("searchWord");

// new HashMap<String, List<String>>().
//                entrySet().
//                stream().
//                filter(entry -> !entry.getValue().isEmpty()).
//                collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));

		// @formatter:off
		Map<String, Object> queryDsl = Stream
				.of(new AbstractMap.SimpleEntry<>("from", paramMap.get("offset")),
						new AbstractMap.SimpleEntry<>("size", paramMap.get("pageSize")),
						new AbstractMap.SimpleEntry<>("_source",
								Stream.of(new AbstractMap.SimpleEntry<>("excludes", Arrays.asList("content")))
										.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue))),
						new AbstractMap.SimpleEntry<>(
								"query", Stream
										.of((queryString != null && queryString.length() > 0
												? new AbstractMap.SimpleEntry<>(
														"multi_match", Stream
																.of(new AbstractMap.SimpleEntry<>("fields", fieldList),
																		new AbstractMap.SimpleEntry<>("query",
																				queryString),
																		new AbstractMap.SimpleEntry<>("operator", "or"))
																.collect(Collectors.toMap(Map.Entry::getKey,
																		Map.Entry::getValue)))
												: new AbstractMap.SimpleEntry<>("match_all", new HashMap())))
										.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue))),
						new AbstractMap.SimpleEntry<>("highlight", Stream.of(
								new AbstractMap.SimpleEntry<>("pre_tags",
										Arrays.asList("<span style='background:yellow;color:black;'>")),
								new AbstractMap.SimpleEntry<>("post_tags", Arrays.asList("</span>")),
								new AbstractMap.SimpleEntry<>("fields", Stream.of(
										new AbstractMap.SimpleEntry<>("name", new HashMap()),
										new AbstractMap.SimpleEntry<>("content", Stream
												.of(new AbstractMap.SimpleEntry<>("fragment_size", 200),
														new AbstractMap.SimpleEntry<>("no_match_size", 200),
														new AbstractMap.SimpleEntry<>("number_of_fragments", 1),
														new AbstractMap.SimpleEntry<>("pre_tags", Arrays.asList(
																"<span style='background:yellow;color:black;'>")),
														new AbstractMap.SimpleEntry<>("post_tags",
																Arrays.asList("</span>")))
												.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue))))
										.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue))))
								.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue))))
				.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
		// @formatter:on

		ObjectMapper mapper = new ObjectMapper();
		String queryJson = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(queryDsl);
		System.out.println(queryJson);

		Search.Builder searchBuilder = new Search.Builder(queryJson).addIndex("documents").addType("document");
		Search search = searchBuilder.build();

		SearchResult result = jestClient.execute(search);

		return result;
	}

	public SearchResult search_content(Map<String, Object> paramMap) throws Exception {

		List<String> fieldList = new ArrayList<String>();
		fieldList.add("path_with_ext");

		String queryString = (String) paramMap.get("searchTarget");

		// @formatter:off
		Map<String, Object> queryDsl = Stream.of(new AbstractMap.SimpleEntry<>("query", Stream.of((queryString != null && queryString.length() > 0
				? new AbstractMap.SimpleEntry<>("term", Stream.of(new AbstractMap.SimpleEntry<>("path_with_ext.keyword", queryString)).collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue)))
				: new AbstractMap.SimpleEntry<>("match_all", new HashMap()))).collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue))))
				.collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
		// @formatter:on

		ObjectMapper mapper = new ObjectMapper();
		String queryJson = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(queryDsl);
		System.out.println(queryJson);

		Search.Builder searchBuilder = new Search.Builder(queryJson).addIndex("documents").addType("document");
		Search search = searchBuilder.build();

		SearchResult result = jestClient.execute(search);

		return result;
	}
}