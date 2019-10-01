package test;

import java.io.File;

public class PathTest {
	public static void main(String[] args) throws Exception {
		String path = "data/tmp/case/";

		File f = new File(path, "aaa/bb");
		System.out.println(f.getCanonicalPath());
	}
}
