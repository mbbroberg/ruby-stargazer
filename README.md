# ruby-stargazer
A tool to tally unique starrers across GitHub repositories


## How to use
Create a file titled "pw.config" and formatted as shown in the follwowing example:
```
USR="TommyBoy"
PW="aVanByTheRiver!"
```

Next, execute the corresponding ruby script.  The results go to stdout, so feel free to pipe to a file.

```
ruby commits_list.rb > out.csv
``` 
