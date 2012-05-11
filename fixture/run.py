#!/usr/bin/env python
#-*- coding: utf-8 -*-

import Media
import LoanHistory
import Users

if __name__ == "__main__":
  content = ""
  content += "# Users\n"
  content += "#======\n"
  content += Users.main()
  content += "# Media\n"
  content += "#======\n"
  content += Media.main()
  content += "# LoanHistories\n"
  content += "#==============\n"
  content += LoanHistory.main()
  open("All.sql", "w").write(content)
