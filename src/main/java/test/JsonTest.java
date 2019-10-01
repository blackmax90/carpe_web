package test;

import java.util.AbstractMap;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import com.fasterxml.jackson.databind.ObjectMapper;

public class JsonTest {
	public static AbstractMap.SimpleEntry<String, Object> getMap() {
		return new AbstractMap.SimpleEntry<>("name", new HashMap());
	}
	
	public static void main(String[] args) throws Exception {
		
		String searchString = "지정과제";
		//String searchString = null;
		
		// @formatter:off
		Map<String, Object> queryDsl = Stream.of (
			new AbstractMap.SimpleEntry<>("from", 0), 
			new AbstractMap.SimpleEntry<>("size", 10),
			new AbstractMap.SimpleEntry<>("_source", Stream.of (
				new AbstractMap.SimpleEntry<>("excludes", Arrays.asList("content"))
			).collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue))),
			(searchString != null ?
  			new AbstractMap.SimpleEntry<>("query", Stream.of (
				new AbstractMap.SimpleEntry<>("multi_match", Stream.of (
					new AbstractMap.SimpleEntry<>("fields", Arrays.asList("name", "content")),
					new AbstractMap.SimpleEntry<>("query", searchString),
					new AbstractMap.SimpleEntry<>("operator", "or")
				).collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue)))
			).collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue)))
			: new AbstractMap.SimpleEntry<>("match_all", new HashMap())
			),
			new AbstractMap.SimpleEntry<>("highlight", Stream.of (
				new AbstractMap.SimpleEntry<>("fields", Stream.of (
					new AbstractMap.SimpleEntry<>("name", new HashMap()),
					new AbstractMap.SimpleEntry<>("content", Stream.of (
						new AbstractMap.SimpleEntry<>("fragment_size", 50),
						new AbstractMap.SimpleEntry<>("no_match_size", 50),
						new AbstractMap.SimpleEntry<>("number_of_fragments", 1),
						new AbstractMap.SimpleEntry<>("pre_tags", Arrays.asList("<strong>")),
						new AbstractMap.SimpleEntry<>("post_tags", Arrays.asList("</strong>"))
					).collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue)))
				).collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue)))
			).collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue)))
		).collect(Collectors.toMap(Map.Entry::getKey, Map.Entry::getValue));
  		// @formatter:on

		ObjectMapper mapper = new ObjectMapper();
		String json2 = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(queryDsl);
		System.out.println(json2);
	}

}
