package com.carpe.common.search;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import io.searchbox.client.JestClient;
import io.searchbox.client.JestClientFactory;
import io.searchbox.client.config.HttpClientConfig;

@Configuration
public class JestClientConfiguration {
	@Value("#{carpe_config['elasticsearch.endpoint']}")
	private String es_endpoint;

	@Value("#{carpe_config['elasticsearch.max_connection']}")
	private int es_max_connection;

	@Value("#{carpe_config['elasticsearch.conn_timeout']}")
	private int es_conn_timeout;

	@Value("#{carpe_config['elasticsearch.read_timeout']}")
	private int es_read_timeout;

	@Bean
	public JestClient jestClient() {
		// @formatter:off
		HttpClientConfig clientConfig = new HttpClientConfig.Builder(es_endpoint)
			.multiThreaded(true)
			.maxTotalConnection(es_max_connection)
			.connTimeout(es_conn_timeout)
			.readTimeout(es_read_timeout)
		.build();
		// @formatter:on

		JestClientFactory factory = new JestClientFactory();
		factory.setHttpClientConfig(clientConfig);
		JestClient client = factory.getObject();

		return client;
	}
}