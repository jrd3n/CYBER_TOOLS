# 1. Robots.txt
Open `/robots.txt` and see if there are any pages that are disallowed.

# 2. url

Look at the url for things like `/my-account?id=21175cae-49e6-4fff-a6a1-de423936b778` the id can be changed.
# 2. .html

Have look at the .html code. We are looking for things like:
1. [[File path traversal]], `<img src="/loadImage?filename=218.png">`
# 3.  .js

Have a look at the .js files. We are looking for things like:
1. hrefs

# 4. Cookies
Press F12, go to the memory/Application tab. look for the cookies section. we are looking for:
1. editable fields.
2. 
## Parameter-based access control methods

Some applications determine the user's access rights or role at login, and then store this information in a user-controllable location. This could be:

- A hidden field.
- A cookie.
- A preset query string parameter.

