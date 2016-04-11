This demo still works.  Open 102B_jenkins_install.ipynb, do "Run All".
Then open tiny_web_example.ipynb and change set-github-user to some
github user that has a fork of
https://github.com/axsh/tiny_web_example that has been edited such
that it passes the unit tests.  For example, if such a fork exists at
https://github.com/myid/tiny_web_example, then edit the cell in the
"Setup github" section of tiny_web_example.ipynb to look like this:

```
# Set github details
set-github-user "myid"
set-github-repo "tiny_web_example"
```

Then do "Run All" on the tiny_web_example.ipynb notebook.  This will
create 5 jobs in Jenkins.  Doing "Build now" on the job named
"tiny_web.rspec" will build all the jobs.
