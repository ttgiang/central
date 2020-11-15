package com.ase.aseutil.faq;

import javax.servlet.http.HttpServletRequest;

public class NullCommand implements Command {
  private String next;

  public NullCommand(String next) {
    this.next = next;
  }

  public String execute(HttpServletRequest req)
    throws CommandException {
    return next;
  }

}
