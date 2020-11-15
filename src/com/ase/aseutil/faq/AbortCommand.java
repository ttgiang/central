package com.ase.aseutil.faq;

import javax.servlet.http.HttpServletRequest;

public class AbortCommand implements Command {
  private String next;

  public AbortCommand(String next) {
    this.next = next;
  }

  public String execute(HttpServletRequest req)
    throws CommandException {
    req.setAttribute("faqtool.msg", "Operation Aborted");
    return next;
  }

}
