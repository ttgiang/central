package com.ase.aseutil.faq;

public class UnknownFaqException extends FaqRepositoryException {

	private static final long serialVersionUID = 12L;

  public UnknownFaqException() {
    super();
  }

  public UnknownFaqException(String msg) {
    super(msg);
  }
}
