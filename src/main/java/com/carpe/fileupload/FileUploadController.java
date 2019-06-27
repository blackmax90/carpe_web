package com.carpe.fileupload;

import java.io.File;
import java.util.HashMap;
import java.util.Locale;

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

@Controller
public class FileUploadController {

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
}