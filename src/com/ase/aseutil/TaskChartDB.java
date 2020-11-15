/**
 * Copyright 2007 Applied Software Engineering, LLC. All rights reserved. You
 * may not modify, use, reproduce, or distribute this software except in
 * compliance with the terms of the License made with Applied Software
 * Engineering
 *
 * @author ttgiang
 *
 */

//
// TaskChartDB.java
//
package com.ase.aseutil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.log4j.Logger;

public class TaskChartDB {
	static Logger logger = Logger.getLogger(TaskChartDB.class.getName());

	public TaskChartDB() throws Exception {}

	/*
	 * getTaskChart
	 *	<p>
	 *	@param	conn		Connection
	 *	@param	task		String
	 *	@param	status	boolean
	 *	<p>
	 * @return TaskChart
	 */
	public static TaskChart getTaskChart(Connection conn,String task,boolean status) throws Exception {

		// this section differs from the bottom in that this section uses a database and the
		// bottom uses hard coding

		String sql = "SELECT message,progress,source FROM tblTaskChart WHERE status=? AND status=?";
		TaskChart taskChart = null;

		try {
			PreparedStatement ps = conn.prepareStatement(sql);
			ps.setString(1,task);
			ps.setBoolean(2,status);
			ResultSet rs = ps.executeQuery();
			if (rs.next()) {
				taskChart = new TaskChart();
				taskChart.setMessage(AseUtil.nullToBlank(rs.getString("message")));
				taskChart.setProgress(AseUtil.nullToBlank(rs.getString("progress")));
				taskChart.setSource(AseUtil.nullToBlank(rs.getString("source")));
			}
			rs.close();
			ps.close();
		} catch (Exception e) {
			logger.fatal("TaskChartDB: getTaskChart - " + e.toString());
		}

		return taskChart;
	}

	/*
	 * getMessageText
	 * <p>
	 *	@param	message			String
	 * <p>
	 *	@return	String
	 */
	public static String getMessageText(String message) throws SQLException {

		String taskMessage = message;

		if (message.equals(Constant.APPROVAL_TEXT)){
			taskMessage = "(message='"+Constant.APPROVAL_TEXT+"' "
						+ "OR message='"+Constant.APPROVAL_TEXT_NEW+"' "
						+ "OR message='"+Constant.APPROVAL_TEXT_EXISTING+"')";
		}
		else if (message.equals(Constant.APPROVED_TEXT)){
			taskMessage = "(message='"+Constant.APPROVED_TEXT+"' "
						+ "OR message='"+Constant.APPROVED_TEXT_NEW+"' "
						+ "OR message='"+Constant.APPROVED_TEXT_EXISTING+"')";
		}
		else if (message.equals(Constant.DELETE_TEXT)){
			taskMessage = "(message='"+Constant.DELETE_TEXT+"' "
						+ "OR message='"+Constant.DELETE_TEXT_EXISTING+"' "
						+ "OR message='"+Constant.DELETED_TEXT+"')";
		}
		else if (message.equals(Constant.MODIFY_TEXT)){
			taskMessage = "(message='"+Constant.MODIFY_TEXT+"' "
						+ "OR message='"+Constant.MODIFY_TEXT_NEW+"' "
						+ "OR message='"+Constant.MODIFY_TEXT_EXISTING+"')";
		}
		else if (message.equals(Constant.RENAME_REQUEST_TEXT)){
			taskMessage = "(message='"+Constant.RENAME_REQUEST_TEXT+"')";
		}
		else if (message.equals(Constant.RENAME_APPROVAL_TEXT)){
			taskMessage = "(message='"+Constant.RENAME_APPROVAL_TEXT+"')";
		}
		else if (message.equals(Constant.REVIEW_TEXT)){
			taskMessage = "(message='"+Constant.REVIEW_TEXT+"' "
						+ "OR message='"+Constant.REVIEW_TEXT_NEW+"' "
						+ "OR message='"+Constant.REVIEW_TEXT_EXISTING+"')";
		}
		else if (message.equals(Constant.REVISE_TEXT)){
			taskMessage = "(message='"+Constant.REVISE_TEXT+"' "
						+ "OR message='"+Constant.REVISE_TEXT_NEW+"' "
						+ "OR message='"+Constant.REVISE_TEXT_EXISTING+"')";
		}
		else if (message.equals(Constant.PROGRAM_APPROVAL_TEXT)){
			taskMessage = "(message='"+Constant.PROGRAM_APPROVAL_TEXT+"' "
						+ "OR message='"+Constant.PROGRAM_APPROVAL_TEXT_NEW+"' "
						+ "OR message='"+Constant.PROGRAM_APPROVAL_TEXT_EXISTING+"')";
		}
		else if (message.equals(Constant.PROGRAM_APPROVED_TEXT)){
			taskMessage = "(message='"+Constant.PROGRAM_APPROVED_TEXT+"' "
						+ "OR message='"+Constant.PROGRAM_APPROVED_TEXT_NEW+"' "
						+ "OR message='"+Constant.PROGRAM_APPROVED_TEXT_EXISTING+"')";
		}
		else if (message.equals(Constant.PROGRAM_MODIFY_TEXT)){
			taskMessage = "(message='"+Constant.PROGRAM_MODIFY_TEXT+"' "
						+ "OR message='"+Constant.PROGRAM_MODIFY_TEXT_NEW+"' "
						+ "OR message='"+Constant.PROGRAM_MODIFY_TEXT_EXISTING+"')";
		}
		else if (message.equals(Constant.PROGRAM_REVIEW_TEXT)){
			taskMessage = "(message='"+Constant.PROGRAM_REVIEW_TEXT+"' "
						+ "OR message='"+Constant.PROGRAM_REVIEW_TEXT_NEW+"' "
						+ "OR message='"+Constant.PROGRAM_REVIEW_TEXT_EXISTING+"')";
		}
		else if (message.equals(Constant.PROGRAM_REVISE_TEXT)){
			taskMessage = "(message='"+Constant.PROGRAM_REVISE_TEXT+"' "
						+ "OR message='"+Constant.PROGRAM_REVISE_TEXT_NEW+"' "
						+ "OR message='"+Constant.PROGRAM_REVISE_TEXT_EXISTING+"')";
		}
		else if (message.equals(Constant.FND_APPROVAL_TEXT)){
			taskMessage = "(message='"+Constant.FND_APPROVAL_TEXT+"' "
						+ "OR message='"+Constant.FND_APPROVAL_TEXT_NEW+"' "
						+ "OR message='"+Constant.FND_APPROVAL_TEXT_EXISTING+"')";
		}
		else if (message.equals(Constant.FND_APPROVED_TEXT)){
			taskMessage = "(message='"+Constant.FND_APPROVED_TEXT+"' "
						+ "OR message='"+Constant.FND_APPROVED_TEXT_NEW+"' "
						+ "OR message='"+Constant.FND_APPROVED_TEXT_EXISTING+"')";
		}
		else if (message.equals(Constant.FND_MODIFY_TEXT)){
			taskMessage = "(message='"+Constant.FND_MODIFY_TEXT+"' "
						+ "OR message='"+Constant.FND_MODIFY_TEXT_NEW+"' "
						+ "OR message='"+Constant.FND_MODIFY_TEXT_EXISTING+"')";
		}
		else if (message.equals(Constant.FND_REVIEW_TEXT)){
			taskMessage = "(message='"+Constant.FND_REVIEW_TEXT+"' "
						+ "OR message='"+Constant.FND_REVIEW_TEXT_NEW+"' "
						+ "OR message='"+Constant.FND_REVIEW_TEXT_EXISTING+"')";
		}
		else if (message.equals(Constant.FND_REVISE_TEXT)){
			taskMessage = "(message='"+Constant.FND_REVISE_TEXT+"' "
						+ "OR message='"+Constant.FND_REVISE_TEXT_NEW+"' "
						+ "OR message='"+Constant.FND_REVISE_TEXT_EXISTING+"')";
		}
		else{
			taskMessage = "message='"+message+"'";
		}

		return taskMessage;
	}

	/*
	 * getTaskChart
	 *	<p>
	 *	this version does not use a database table. It relies on constants. This was done
	 * because task message display happens often and a static class was considered over
	 * a database read to go easy on I/O.
	 *	<p>
	 *	@param	task				String
	 *	@param	courseExist		boolean
	 *	@param	programExist	boolean
	 *	@param	isAProgram		boolean
	 *	<p>
	 * @return TaskChart
	 */
	public static TaskChart getTaskChart(String task,boolean courseExist,boolean programExist,boolean isAProgram) throws Exception {

		return getTaskChart(task,courseExist,programExist,isAProgram,false,false);
	}

	public static TaskChart getTaskChart(String task,boolean courseExist,boolean programExist,boolean isAProgram,boolean foundation,boolean fndExist) throws Exception {

		//Logger logger = Logger.getLogger("test");

		TaskChart taskChart = new TaskChart();

		boolean debug = false;

		if (debug) {
			logger.info("----------- getTaskChart");
			logger.info("task - " + task);
			logger.info("courseExist - " + courseExist);
			logger.info("programExist - " + programExist);
			logger.info("isAProgram - " + isAProgram);
		}

		if (task.equals(Constant.MESSAGE_BOARD_REPLY_TEXT)){
			if (debug) logger.info("00 - " + Constant.MESSAGE_BOARD_REPLY_TEXT);

			taskChart.setMessage(Constant.MESSAGE_BOARD_REPLY_TEXT);
			taskChart.setSource(Constant.MESSAGE_BOARD_REPLY_SRC);
			taskChart.setProgress(Constant.BLANK);
		}
		else if (task.equals(Constant.APPROVAL_PENDING_TEXT)){

			if (debug) logger.info("10 - " + Constant.APPROVAL_PENDING_TEXT);

			taskChart.setMessage(Constant.APPROVAL_PENDING_TEXT);
			taskChart.setSource(Constant.APPROVAL_PENDING_TEXT_SRC);
			taskChart.setProgress(Constant.COURSE_APPROVAL_TEXT);
		}
		else if (task.equals(Constant.DELETE_APPROVAL_PENDING_TEXT)){

			if (debug) logger.info("12 - " + Constant.DELETE_APPROVAL_PENDING_TEXT);

			taskChart.setMessage(Constant.DELETE_APPROVAL_PENDING_TEXT);
			taskChart.setSource(Constant.APPROVAL_PENDING_TEXT_SRC);
			taskChart.setProgress(Constant.COURSE_DELETE_TEXT);
		}
		else if (task.equals(Constant.APPROVE_REQUISITE_TEXT)){

			if (debug) logger.info("20 - " + Constant.APPROVE_REQUISITE_TEXT);

			taskChart.setMessage(Constant.APPROVE_REQUISITE_TEXT);
			taskChart.setSource(Constant.APPROVE_REQUISITE_TEXT_SRC);
			taskChart.setProgress(Constant.COURSE_APPROVAL_TEXT);
		}
		else if (task.equals(Constant.APPROVE_CROSS_LISTING_TEXT)){

			if (debug) logger.info("30 - " + Constant.APPROVE_CROSS_LISTING_TEXT);

			taskChart.setMessage(Constant.APPROVE_CROSS_LISTING_TEXT);
			taskChart.setSource(Constant.APPROVE_CROSS_LISTING_TEXT_SRC);
			taskChart.setProgress(Constant.COURSE_APPROVAL_TEXT);
		}
		else if (task.equals(Constant.APPROVE_PROGRAM_TEXT)){

			if (debug) logger.info("40 - " + Constant.APPROVE_PROGRAM_TEXT);

			taskChart.setMessage(Constant.APPROVE_PROGRAM_TEXT);
			taskChart.setSource(Constant.APPROVE_PROGRAM_TEXT_SRC);
			taskChart.setProgress(Constant.PROGRAM_APPROVAL_PROGRESS);
		}
		else if (task.equals(Constant.MAIL_LOG_TEXT)){

			if (debug) logger.info("50 - " + Constant.MAIL_LOG_TEXT);

			taskChart.setMessage(Constant.MAIL_LOG_TEXT);
			taskChart.setSource(Constant.MAIL_LOG_TEXT_SRC);
			taskChart.setProgress(Constant.NOTIFICATION);
		}
		else if (task.equals(Constant.RENAME_REQUEST_TEXT)){

			if (debug) logger.info("55 - " + Constant.RENAME_REQUEST_TEXT);

			taskChart.setMessage(Constant.RENAME_REQUEST_TEXT);
			taskChart.setSource(Constant.RENAME_REQUEST_TEXT_SRC);
			taskChart.setProgress(Constant.COURSE_APPROVAL_PENDING_TEXT);
		}
		else if (task.equals(Constant.RENAME_APPROVAL_TEXT)){

			if (debug) logger.info("57 - " + Constant.RENAME_APPROVAL_TEXT);

			taskChart.setMessage(Constant.RENAME_APPROVAL_TEXT);
			taskChart.setSource(Constant.RENAME_APPROVAL_TEXT_SRC);
			taskChart.setProgress(Constant.COURSE_APPROVAL_TEXT);
		}
		else{

			if (foundation){

				if (debug) logger.info("60 - foundation");

				if (fndExist){
					if (task.toLowerCase().indexOf("approv") > -1){
						if (task.equals(Constant.FND_APPROVED_TEXT)){
							taskChart.setMessage(Constant.FND_APPROVED_TEXT_EXISTING);
							taskChart.setSource(Constant.FND_APPROVED_TEXT_SRC);
						}
						else if (task.equals(Constant.FND_DELETE_TEXT)){
							taskChart.setMessage(Constant.FND_DELETE_TEXT_EXISTING);
							taskChart.setSource(Constant.FND_APPROVAL_TEXT_SRC);
						}
						else{
							taskChart.setMessage(Constant.FND_APPROVAL_TEXT_EXISTING);
							taskChart.setSource(Constant.FND_APPROVAL_TEXT_SRC);
						}

						taskChart.setProgress(Constant.TASK_APPROVE);
					}
					else if (task.toLowerCase().indexOf("create") > -1){
						taskChart.setMessage(Constant.FND_MODIFY_TEXT_EXISTING);
						taskChart.setSource(Constant.FND_MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_NEW);
					}
					else if (task.toLowerCase().indexOf("delete") > -1){
						taskChart.setMessage(Constant.FND_DELETE_TEXT);
						taskChart.setSource(Constant.FND_APPROVED_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_DELETE);
					}
					else if (task.toLowerCase().indexOf("modify") > -1 || task.toLowerCase().indexOf("work on") > -1){
						taskChart.setMessage(Constant.FND_MODIFY_TEXT_EXISTING);
						taskChart.setSource(Constant.FND_MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_MODIFY);
					}
					else if (task.toLowerCase().indexOf("review") > -1){
						taskChart.setMessage(Constant.FND_REVIEW_TEXT_EXISTING);
						taskChart.setSource(Constant.FND_REVIEW_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_REVIEW);
					}
					else if (task.toLowerCase().indexOf("revise") > -1){
						taskChart.setMessage(Constant.FND_REVISE_TEXT_EXISTING);
						taskChart.setSource(Constant.FND_MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_REVISE);
					}
				}
				else{
					if (task.toLowerCase().indexOf("approv") > -1){
						if (task.equals(Constant.FND_APPROVED_TEXT)){
							taskChart.setMessage(Constant.FND_APPROVED_TEXT_NEW);
							taskChart.setSource(Constant.FND_APPROVED_TEXT_SRC);
						}
						else if (task.equals(Constant.FND_DELETE_TEXT)){
							taskChart.setMessage(Constant.FND_DELETE_TEXT_EXISTING);
							taskChart.setSource(Constant.FND_APPROVAL_TEXT_SRC);
						}
						else{
							taskChart.setMessage(Constant.FND_APPROVAL_TEXT_NEW);
							taskChart.setSource(Constant.FND_APPROVAL_TEXT_SRC);
						}

						taskChart.setProgress(Constant.TASK_NEW);
					}
					else if (task.toLowerCase().indexOf("create") > -1){
						taskChart.setMessage(Constant.FND_MODIFY_TEXT_NEW);
						taskChart.setSource(Constant.FND_MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_NEW);
					}
					else if (task.toLowerCase().indexOf("delete") > -1){
						taskChart.setMessage(Constant.FND_DELETE_TEXT);
						taskChart.setSource(Constant.FND_APPROVED_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_NEW);
					}
					else if (task.toLowerCase().indexOf("modify") > -1 || task.toLowerCase().indexOf("work on") > -1){
						taskChart.setMessage(Constant.FND_MODIFY_TEXT_NEW);
						taskChart.setSource(Constant.FND_MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_NEW);
					}
					else if (task.toLowerCase().indexOf("review") > -1){
						taskChart.setMessage(Constant.FND_REVIEW_TEXT_NEW);
						taskChart.setSource(Constant.FND_REVIEW_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_NEW);
					}
					else if (task.toLowerCase().indexOf("revise") > -1){
						taskChart.setMessage(Constant.FND_REVISE_TEXT_NEW);
						taskChart.setSource(Constant.FND_MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_NEW);
					}
				} // fndExist
			}
			else if (isAProgram){

				if (debug) logger.info("60 - isAProgram");

				if (programExist){
					if (task.toLowerCase().indexOf("approv") > -1){
						if (task.equals(Constant.PROGRAM_APPROVED_TEXT)){
							taskChart.setMessage(Constant.PROGRAM_APPROVED_TEXT_EXISTING);
							taskChart.setSource(Constant.PROGRAM_APPROVED_TEXT_SRC);
						}
						else if (task.equals(Constant.PROGRAM_DELETE_TEXT)){
							taskChart.setMessage(Constant.PROGRAM_DELETE_TEXT_EXISTING);
							taskChart.setSource(Constant.PROGRAM_APPROVAL_TEXT_SRC);
						}
						else{
							taskChart.setMessage(Constant.PROGRAM_APPROVAL_TEXT_EXISTING);
							taskChart.setSource(Constant.PROGRAM_APPROVAL_TEXT_SRC);
						}

						taskChart.setProgress(Constant.TASK_APPROVE);
					}
					else if (task.toLowerCase().indexOf("create") > -1){
						taskChart.setMessage(Constant.PROGRAM_MODIFY_TEXT_EXISTING);
						taskChart.setSource(Constant.PROGRAM_MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_NEW);
					}
					else if (task.toLowerCase().indexOf("delete") > -1){
						taskChart.setMessage(Constant.PROGRAM_DELETE_TEXT);
						taskChart.setSource(Constant.PROGRAM_APPROVED_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_DELETE);
					}
					else if (task.toLowerCase().indexOf("modify") > -1 || task.toLowerCase().indexOf("work on") > -1){
						taskChart.setMessage(Constant.PROGRAM_MODIFY_TEXT_EXISTING);
						taskChart.setSource(Constant.PROGRAM_MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_MODIFY);
					}
					else if (task.toLowerCase().indexOf("review") > -1){
						taskChart.setMessage(Constant.PROGRAM_REVIEW_TEXT_EXISTING);
						taskChart.setSource(Constant.PROGRAM_REVIEW_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_REVIEW);
					}
					else if (task.toLowerCase().indexOf("revise") > -1){
						taskChart.setMessage(Constant.PROGRAM_REVISE_TEXT_EXISTING);
						taskChart.setSource(Constant.PROGRAM_MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_REVISE);
					}
				}
				else{
					if (task.toLowerCase().indexOf("approv") > -1){
						if (task.equals(Constant.PROGRAM_APPROVED_TEXT)){
							taskChart.setMessage(Constant.PROGRAM_APPROVED_TEXT_NEW);
							taskChart.setSource(Constant.PROGRAM_APPROVED_TEXT_SRC);
						}
						else if (task.equals(Constant.PROGRAM_DELETE_TEXT)){
							taskChart.setMessage(Constant.PROGRAM_DELETE_TEXT_EXISTING);
							taskChart.setSource(Constant.PROGRAM_APPROVAL_TEXT_SRC);
						}
						else{
							taskChart.setMessage(Constant.PROGRAM_APPROVAL_TEXT_NEW);
							taskChart.setSource(Constant.PROGRAM_APPROVAL_TEXT_SRC);
						}

						taskChart.setProgress(Constant.TASK_NEW);
					}
					else if (task.toLowerCase().indexOf("create") > -1){
						taskChart.setMessage(Constant.PROGRAM_MODIFY_TEXT_NEW);
						taskChart.setSource(Constant.PROGRAM_MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_NEW);
					}
					else if (task.toLowerCase().indexOf("delete") > -1){
						taskChart.setMessage(Constant.PROGRAM_DELETE_TEXT);
						taskChart.setSource(Constant.PROGRAM_APPROVED_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_NEW);
					}
					else if (task.toLowerCase().indexOf("modify") > -1 || task.toLowerCase().indexOf("work on") > -1){
						taskChart.setMessage(Constant.PROGRAM_MODIFY_TEXT_NEW);
						taskChart.setSource(Constant.PROGRAM_MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_NEW);
					}
					else if (task.toLowerCase().indexOf("review") > -1){
						taskChart.setMessage(Constant.PROGRAM_REVIEW_TEXT_NEW);
						taskChart.setSource(Constant.PROGRAM_REVIEW_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_NEW);
					}
					else if (task.toLowerCase().indexOf("revise") > -1){
						taskChart.setMessage(Constant.PROGRAM_REVISE_TEXT_NEW);
						taskChart.setSource(Constant.PROGRAM_MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_NEW);
					}
				} // programExist
			}
			else{

				if (debug) logger.info("80 - is course");

				if (courseExist){

					if (debug) logger.info("100 - course exists");

					if (task.toLowerCase().indexOf("approv") > -1){

						if (task.equals(Constant.APPROVED_TEXT) || task.equals(Constant.APPROVED_TEXT_EXISTING)){

							if (debug) logger.info("101 - course exists");

							taskChart.setMessage(Constant.APPROVED_TEXT_EXISTING);
							taskChart.setSource(Constant.APPROVED_TEXT_SRC);
							taskChart.setProgress(Constant.TASK_APPROVE);
						}
						else if (task.equals(Constant.DELETE_TEXT) || task.equals(Constant.DELETE_TEXT_EXISTING)){

							if (debug) logger.info("102 - course exists");

							taskChart.setMessage(Constant.DELETE_TEXT_EXISTING);
							taskChart.setSource(Constant.APPROVAL_TEXT_SRC);
							taskChart.setProgress(Constant.TASK_DELETE);
						}
						else {

							if (debug) logger.info("103 - course exists");

							taskChart.setMessage(Constant.APPROVAL_TEXT_EXISTING);
							taskChart.setSource(Constant.APPROVAL_TEXT_SRC);
							taskChart.setProgress(Constant.TASK_APPROVE);
						}

					}
					else if (task.toLowerCase().indexOf("delete") > -1){
						taskChart.setMessage(Constant.DELETE_TEXT_EXISTING);
						taskChart.setSource(Constant.APPROVAL_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_DELETE);
					}
					else if (task.toLowerCase().indexOf("modify") > -1 || task.toLowerCase().indexOf("work on") > -1){
						taskChart.setMessage(Constant.MODIFY_TEXT_EXISTING);
						taskChart.setSource(Constant.MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_MODIFY);
					}
					else if (task.toLowerCase().indexOf("review") > -1){
						taskChart.setMessage(Constant.REVIEW_TEXT_EXISTING);
						taskChart.setSource(Constant.REVIEW_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_REVIEW);
					}
					else if (task.toLowerCase().indexOf("revise") > -1){
						taskChart.setMessage(Constant.REVISE_TEXT_EXISTING);
						taskChart.setSource(Constant.MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_REVISE);
					}
					else{
						taskChart.setMessage(task);
						taskChart.setProgress(Constant.BLANK);
					}
				}
				else{

					if (debug) logger.info("120 - course does not exists");

					if (task.toLowerCase().indexOf("approv") > -1){
						if (task.equals(Constant.APPROVED_TEXT) || task.equals(Constant.APPROVED_TEXT_NEW)){
							taskChart.setMessage(Constant.APPROVED_TEXT_NEW);
							taskChart.setSource(Constant.APPROVED_TEXT_SRC);
						}
						else if (task.equals(Constant.DELETE_TEXT) || task.equals(Constant.DELETE_TEXT_EXISTING)){
							taskChart.setMessage(Constant.DELETE_TEXT_EXISTING);
							taskChart.setSource(Constant.APPROVAL_TEXT_SRC);
						}
						else {
							taskChart.setMessage(Constant.APPROVAL_TEXT_NEW);
							taskChart.setSource(Constant.APPROVAL_TEXT_SRC);
						}

						taskChart.setProgress(Constant.TASK_NEW);
					}
					else if (task.toLowerCase().indexOf("delete") > -1){
						taskChart.setMessage(Constant.DELETE_TEXT);
						taskChart.setSource(Constant.APPROVAL_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_DELETE);
					}
					else if (task.toLowerCase().indexOf("modify") > -1 || task.toLowerCase().indexOf("work on") > -1){
						taskChart.setMessage(Constant.MODIFY_TEXT_NEW);
						taskChart.setSource(Constant.MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_NEW);
					}
					else if (task.toLowerCase().indexOf("review") > -1){
						taskChart.setMessage(Constant.REVIEW_TEXT_NEW);
						taskChart.setSource(Constant.REVIEW_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_NEW);
					}
					else if (task.toLowerCase().indexOf("revise") > -1){
						taskChart.setMessage(Constant.REVISE_TEXT_NEW);
						taskChart.setSource(Constant.MODIFY_TEXT_SRC);
						taskChart.setProgress(Constant.TASK_NEW);
					}
					else{
						taskChart.setMessage(task);
						taskChart.setProgress(Constant.BLANK);
					}
				} // exist

			} // isAProgram

		}

		return taskChart;
	}

	/*
	 * getEquivalentMessage
	 *	<p>
	 *	returns the equivalent message for the one that is coming in.
	 * think of it as converting the old to new.
	 *	<p>
	 *	@param	task				String
	 *	@param	courseExist		boolean
	 *	@param	programExist	boolean
	 *	@param	isAProgram		boolean
	 *	<p>
	 * @return String
	 */
	public static String getEquivalentMessage(String task,boolean courseExist,boolean programExist,boolean isAProgram) {

		try{
			TaskChart tc = TaskChartDB.getTaskChart(task,courseExist,programExist,isAProgram);
			if (tc != null){
				task = tc.getMessage();
			}
		}
		catch(Exception e){
			logger.fatal("TaskChartDB - getEquivalentMessage: " + e.toString());
		}

		return task;
	}

	public void close() throws SQLException {}

}