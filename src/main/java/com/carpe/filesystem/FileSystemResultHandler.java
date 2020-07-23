package com.carpe.filesystem;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ResultContext;
import org.apache.ibatis.session.ResultHandler;

public class FileSystemResultHandler implements ResultHandler {
	public List<Map> returnList = null;
	
	public FileSystemResultHandler(List<Map> returnList) {
		this.returnList = returnList;
	}
	
	@Override
	public void handleResult(ResultContext resultContext) {
		Map data = (Map)resultContext.getResultObject();
		returnList.add(data);
	}
}
