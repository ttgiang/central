package com.ase.exception;

/**
 * @author dlaurent
 *
 * <p>there is a compile-time dependencies on the
 * <code>java.lang.Exception</code> class, which changed between JDK 1.3 and
 * JDK 1.4.</p>
 */
//import java.io.PrintStream;
//import java.io.PrintWriter;

public class CourseException extends Exception {

	public CourseException() {
		super();
	}

	public CourseException(String message) {
		super(message);
	}

	public CourseException(String message, Throwable cause) {
		super(message, cause);
		//super(message);
		//this.nestedThrowable = cause;
	}

	public CourseException(Throwable cause) {
		super(cause);
		//this.nestedThrowable = cause;
	}

//	private Throwable nestedThrowable = null;
//	public void printStackTrace() {
//		super.printStackTrace();
//		if (nestedThrowable != null) {
//			nestedThrowable.printStackTrace();
//		}
//	}
//
//	public void printStackTrace(PrintStream ps) {
//		super.printStackTrace(ps);
//		if (nestedThrowable != null) {
//			nestedThrowable.printStackTrace(ps);
//		}
//	}
//
//	public void printStackTrace(PrintWriter pw) {
//		super.printStackTrace(pw);
//		if (nestedThrowable != null) {
//			nestedThrowable.printStackTrace(pw);
//		}
//	}

}
