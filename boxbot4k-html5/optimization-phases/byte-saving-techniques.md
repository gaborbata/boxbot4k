Byte-saving Techniques
======================

This is a collection of JavaScript wizardry that can shave bytes off of your code.

Arguments
---------
### Use one-letter positional arguments, in alphabetical order

Since arguments will need to be as short as possible, and will likely be reused within their lifetime, it's best to treat them as positionals instead of trying to give them meaning through their name. While using one-letter names marginally aids readability for a single function, keeping a consistent approach helps readability across all functions.

```javascript
function(t,d,v,i,f){...} // before
function(a,b,c,d,e){...} // after
```

### Test argument presence instead of length

Use `in` to check whether a given argument was passed

```javascript
arguments.length>1||(cb=alert) // before
1 in arguments||(cb=alert)     // after
```

If only truthy arguments are of interest, you can even boil that down to

```javascript
arguments[0]&&(cb=alert)       // works only if arguments[0] coerces to true
```

### Embed functionality within arguments

Save delimiters by processing stuff within (unused) arguments

```javascript
a=b<<1+a;x(a,1); // before
x(a=b<<1+a,1);   // after
```

### Reuse parenthesis of the function call

There are some functions which take no argument, and obviously you can reuse the parentheses when calling them. See @snowlord's [RPN](https://gist.github.com/1276436) function.

```
((a=b.pop(),b.pop())+c+a) // before
(b.pop(a=b.pop())+c+a)    // after
```

If you're not sure if a function really takes no arguments, see if its ```.length``` is 0.

Variables
---------
### Use placeholder arguments instead of `var`

Save bytes on the `var` declaration by putting placeholder arguments in the function declaration.

```javascript
function(a){var b=1;...} // before
function(a,b){b=1;...}   // after
```

Please be careful as sometimes `var` declaration is shorter. Take the right decision in each case.

```javascript
function(a,b,c,d){b=1;c=2;d=3;...} // before
function(a){var b=1,c=2,d=3;...}   // after
```

### Re-use variables where possible

Careful reuse of a variable that is no longer needed can save bytes.

```javascript
setTimeout(function(){for(var i=10;i--;)... }, a) // before
setTimeout(function(){for(a=10;a--;)... }, a)     // after
```

### Assign wherever possible

Since assignment returns the assigned value, perform assignment and evaluation at the same time to save bytes. A good example of this is @jed's [JSONP](https://gist.github.com/962814) function, where the string `script` is assigned in the `createElement` method.

```javascript
a=this.localStorage;if(a){...} // before
if(a=this.localStorage){...}   // after
```

### Use an array to swap variables

An array can be used as a temporary placeholder to avoid declaring another variable.

```javascript
var a=1,b=2,c;c=a;a=b;b=c // before
var a=1,b=2;a=[b,b=a][0]  // after
```

Alternatively, for numbers you can save another two bytes:

```javascript
var a=1,b=2;a=[b,b=a][0]  // before
var a=1,b=2;a+=b-(b=a)    // after
```

### Exploit coercion

JavaScript coercion is a blessing and a curse, but sometimes it can be very useful. @jed's [pubsub](https://gist.github.com/976046) function decrements a negative variable, and then concatenates the results with a string, resulting in a string like `someString-123`, which is exploited later by using the hyphen as a split token to return the original string.


### Choose small data format

Required data will often be represented as Array or Object. In many cases, these byte-hungry formats can be replaced by strings. The [Date.parse polyfill](https://gist.github.com/1053863) shows a great example of a conversion table that'd usually be an Object.


Loops
-----
### Omit loop bodies

If you can perform all the logic you need within the conditional part of a loop, you don't need the loop body. For an example, see @jed's [timeAgo](https://gist.github.com/965606) function.

### Use `for` over `while`

`for` and `while` require the same number of bytes, but `for` gives you more control and assignment opportunity.

```javascript
while(i--){...} // before
for(;i--;){...} // after

i=10;while(i--){...} // before
for(i=10;i--;){...}  // after
```

FYI, the second argument to a for-loop can be omitted, too - it will only stop the loop if it returns anything false-y at all.

### Use index presence to iterate arrays of truthy items

When iterating over an array of objects that you know are truthy, short circuit on object presence to save bytes.

```javascript
for(a=[1,2,3,4,5],l=a.length,i=0;i<l;i++){b=a[i];...}
for(a=[1,2,3,4,5],i=0;b=a[i++];){...}
```

### Use `for..in` with assignment to get the keys of an object

```javascript
a=[];i=0;for(b in window)a[i++]=b // before
a=[];i=0;for(a[i++]in window)     // after
```

Coercion Hint: you can coerce the counter from an array: `i=a=[];for(a[i++]in window);`

### Use reverse loops where possible

If an array can be iterated reversely, it may save some bytes:

```javascript
for(a=0;a<x.length;a++)...     // before
for(a=x.length;a--;)...        // after
```

### Use both `for` body and counting expression for multiple operations

```javascript
for(i=3;i--;foo(),bar());   // before
for(i=3;i--;)foo(),bar();   // before
for(i=3;i--;bar())foo();    // after
```

### for..in will not iterate over false - use this to trigger iteration

If for..in encounters anything but an object (or string in any browser but ye olde IE), e.g. false or 0, it will silently continue without iteration.

```javascript
if(c)for(a in b)x(b[a]); // before
for(a in c&&b)x(b[a]);   // after
```

Operators
---------
### Understand operator precedence

[This Mozilla page](https://developer.mozilla.org/en/JavaScript/Reference/Operators/Operator_Precedence) is an excellent resource to get started.

### Understand bitwise operator hacks

### Use `~` with indexOf to test presence

```javascript
hasAnF="This sentence has an f.".indexOf("f")>=0 // before
hasAnF=~"This sentence has an f.".indexOf("f")   // after
```

### Use `,` to chain expressions on one conditional line

```javascript
with(document){open();write("hello");close()}
with(document)open(),write("hello"),close()
```

### Use `[]._` instead of `undefined`
`""._`, `1.._` and `0[0]` also work, but [are slower](http://jsperf.com/undefineds). `void 0` is faster than `undefined` but longer than the alternatives.

### Remove unnecessary space after an operator

Whitespace isn't always needed after an operator and may sometimes be omitted:

```javascript
typeof [] // before
typeof[]  // after
```

Numbers
-------
### Use `~~` and `0|` instead of `Math.floor` for positive numbers

Both of these operator combos will floor numbers (note that since `~` has lower precedence than `|`, they are not identical).

```javascript
rand10=Math.floor(Math.random()*10) // before
rand10=0|Math.random()*10           // after
```

If you are flooring a quotient where the divisor is a multiple of 2, a bit-shift-right will perform both operations in one statement:

```javascript
Math.floor(a/2) // before
a>>1            // after

Math.floor(a / 4) // before
a>>2            // after
```

### Use `A + 0.5 | 0` instead of `Math.round` for positive numbers

```javascript
Math.round(a) // before
a+.5|0        // after
```

Also, for negative number just change `+.5|0` to `-.5|0`

```javascript
Math.round(-a) // before
-a-.5|0        // after
```

### Use `AeB` format for large denary numbers

This is equivalent to `A*Math.pow(10,B)`.

```javascript
million=1000000 // before
million=1e6     // after
```

### Use `A<<B` format for large binary numbers

This is equivalent to `A*Math.pow(2,B)`. See @jed's [rgb2hex](https://gist.github.com/983535) for an example.

```javascript
color=0x100000 // before
color=1<<20    // after
```

### Use `1/0` instead of `Infinity`

It’s shorter. Besides, division by zero gets you free internet points.

```javascript
[Infinity,-Infinity] // before
[1/0,-1/0]           // after
```

### Use division instead of `isFinite()`

Division of 1 by any finite number results nonzero "truthy" value.

```javascript
if(isFinite(a)) // before
if(1/a)         // after
```

### Exploit the "falsiness" of 0

When comparing numbers, it's often shorter to munge the value to 0 first.

```javascript
a==1||console.log("not one") // before
~-a&&console.log("not one")  // after
```

### Use `~` to coerce any non-number to -1,

Used together with the unary `-`, this is a great way to increment numerical variables not yet initialized. This is used on @jed's [JSONP](https://gist.github.com/986269) implementation.

```javascript
i=i||0;i++ // before
i=-~i      // after
```

It can also be used to decrement a variable by flipping around the negation and complement:

```javascript
i=i||0;i-- // before
i=~-i      // after
```

### Use `^` to check if numbers are not equal

```javascript
if(a!=123) // before
if(a^123) // after
```

### Use number base for character to number conversion

`parseInt(n, 36)` is not only a very small character to number conversion, it also has the added value of being case-insensitive, which may save a `.toLowerCase()`, like in [subzey's parseRoman function](https://gist.github.com/1040240).

### Use current date to generate random integers

As seen in [aemkei's Tetris game](https://gist.github.com/1672254#file_annotated.js).

```javascript
i=0|Math.random()*100 // before
i=new Date%100 // after
```

_Note:_ Do not use in fast loops, because the milliseconds might not change!

Strings
-------
### Prefer `slice` over `substr` over `substring`

Prefer `slice(start,stop)` over `substr(start,length)` over `substring(start,stop)`. Omit the second parameter to fetch everything to the end of the string. Do not use negative positions. It may be shorter (e.g. `s.substr(-n)` fetches the last _n_ characters) but does not work in Internet Explorer (including version 9).

### Split using `''`

Use `s.split('')` to create a character array from a string. Unfortunately you can not use `s[i]` to access the characters in the string. This does not work in Internet Explorer (including version 9).

### Split using 0

Save two bytes by using a number as a delimiter in a string to be split, as seen in @jed's [timeAgo](https://gist.github.com/965606) function.

```javascript
"alpha,bravo,charlie".split(",") // before
"alpha0bravo0charlie".split(0)   // after
```

### Use the little-known `.link` method

Strings have a built-in `.link` method that creates an HTML link. This is used in @jed's [linkify](https://gist.github.com/962823) function.

```javascript
html="<a href='"+url+"'>"+text+"</a>" // before
html=text.link(url)                   // after
```

Strings also have several other methods related to HTML, as documented [here](http://www.hunlock.com/blogs/The_Complete_Javascript_Strings_Reference#quickIDX6).

### Use `.search` instead of `.indexOf`

First, because this RegExp implicit is 1 byte shorter, but you get the added value of coercion of undefined to /undefined/ instead of '' being matched at position zero. This is used in @atk's [base64decoder] (https://gist.github.com/1020396) function.

**Warning:** This will fail when you search with an invalid regular expression. For example, ```'.'``` as ```/./``` matches any character, ```'+'``` as /+/ gives an error so you'd want to ensure you know what the value is.

### Use `.replace` or `.exec` for powerful string iteration

Since the `.replace` method can take a function as its second argument, it can handle a lot of iteration bookkeeping for you. You can see this exploited in @jed's [templates](https://gist.github.com/964762) and [UUID](https://gist.github.com/982883) functions.

### Use `Array` to repeat a string

```javascript
for(a="",i=32;i--;)a+=0 // before
a=Array(33).join(0)     // after
```

Conditionals
------------
### Use `&&` and `||` where possible

```javascript
if(a)if(b)return c // before
return a&&b&&c     // after

if(!a)a=Infinity // before
a=a||Infinity    // after
```

### Coercion to test for types

Instead of using `typeof x=='string'`, you can use `''+x===x`.

Instead of using `typeof x=='number'`, you can use `+x===x`. `+x` will coerce x to a number or NaN, so if it is anything else but a number, this will turn false. **Warning:** If someone goes really crazy on the prototypes, this will probably fail.

Instead of using `typeof x=='function'`, you can use `/^f/.test(typeof x)` as in @tkissing's [template engine](https://gist.github.com/1347239).

### Type-specific methods to test for types

Another way to test types is to check if type-specific methods are available. (Seen on @adius [DOMinate](https://github.com/adius/DOMinate))

Test the variable x with the shortest type specific method:

| Type | Test |
|------|------|
| String | x.big |
| Number | x.toFixed |
| Array | x.pop (x.map works on fewer browsers)|
| Function | x.call |
| textNode | x.data |

This technique is even faster than string comparison!

**Warning:** This will lead to wrong results if properties or methods with those names were added.

Arrays
------
### Use elision

Array elision can be used in some cases to save bytes. See @jed's [router](https://gist.github.com/964605) API for a real-world example.

```javascript
[undefined,undefined,2] // before
[,,2]                   // after

// Note: Be mindful of elided elements at the end of the element list
[2,undefined,undefined] // before length is 3
[2,,]                   // after length is 2
```

You may notice that the ```undefined``` turns empty. In fact, when we coerce an array into a string, the ```undefined``` turns to empty string. See one exploitation from @aemkei's [Digital Segment Display](https://gist.github.com/1272408)

```
b="";b+=x // before
b=[b]+x   // after
// Bonus: b=x+[b] uses same bytes as b=[b]+x, while b="";b=x+b uses one more byte over b="";b+=x.
```

Another exploitation is also useful:

```
((b=[1,2][a])?b:'') // before
[[1,2][a]]          // after
```

### Use coercion to do `.join(',')`

You can use `''+array` instead of `array.join(',')` since the default separator of arrays is ",".

Warning: this will only work if the contents of the Array are true-ish (except false) and consist of Strings (will not be quoted!), Numbers or Booleans, Objects and Arrays within arrays may lead to unwanted results:

````javascript
''+[1,true,false,{x:1},0,'',2,['test',2]]
// "1,true,false,[object Object],0,,2,test,2"
```

### String coercion with array literal ```[]```

```
''+1e3+3e7 // before
[1e3]+3e7  // after
```
See @jed's [UUID](https://gist.github.com/982883) function.

### Use coercion to build strings with commas in them

````javascript
"rgb("+(x+8)+","+(y-20)+","+z+")"; // before
"rgb("+[x+8,y-20,z]+")";           // after
```
Or if the first or last values are static:

````javascript
"rgb(255,"+(y-20)+",0)"; // before
"rgb(255,"+[y-20,"0)"];  // after
```

### Use Arrays as Objects
When you need to return an Object, re-use an already declared Array to store properties. An Array is of type 'object', after all. Make sure the field names don't collide with any of Array's intrinsic properties.

### Test if Array has Several Elements

You can write `if(array[1])` instead of `if(array.length > 1)`

**Warning:** This doesn't work when the item `array[1]` is falsy! So only use it when you can be sure that it's not.

Regular Expressions
-------------------
### Use shortcuts

`\d` is short for `[0-9]` and `\w` is short for `[A-Z_a-z0-9_]`. `\s` matches whitespace. Upper case shortcuts are inverted, e.g. `\D` matches non-digits. You can use these shortcuts inside character classes, e.g. `[\dA-F]` matches hex characters.

`\b` does not match a character but a word boundary where a word and a non-word character met (or vice versa). `\B` matches everywhere except at word boundaries. Some other shortcuts do _not_ work, e.g. `\Q...\E`. For a full list check the ECMA column in the [Regular Expression Flavor Comparison](http://www.regular-expressions.info/refflavors.html).

`/a|b/` is the same as `/(a|b)/`.

Sometimes it's shorter to use `<.*?>` (ungreedy matching) instead of `<[^>]*>` to match (for example) an HTML tag. But this may also change the runtime and behavior of the regular expression in rare cases.

In the replacement string, `$&` refers to the entire match and ``$` `` and `$'` refer to everything before and after the match, so `/(x)/,'$1'` can be replaced with `/x/,'$&'`.

### Denormalize to shorten

While `/\d{2}/` looks smarter, `/\d\d/` is shorter.

### Don't escape

In many cases almost no escaping (with `\`) is needed even if you are using characters that have a meaning in regular expressions. For example, `[[\]-]` is a character class with the three characters `[`, `]` (this needs to be escaped) and `-` (no need to escape this if it's the last character in the class).

### `eval()` for a regexp literal can be shorter than `RegExp()`

Prefer `/\d/g` over `new RegExp('\\d','g')` if possible. If you need to build a regular expression at runtime, consider using `eval()`.

```javascript
// we escape the first curly bracket so if `p` is a number it won't be
// interpreted as an invalid repetition operator.
r=new RegExp("\\\\{"+p+"}","g") // before
r=eval("/\\\\{"+p+"}/g")    // after
```

### `eval()` around String.replace() instead of callback

If a callback is used to achieve a certain effect on the output, one can use replace to build the expression that achieves the same effect and evaluate it (the more complicated the matches are, the less this will help):

```javascript
x.replace(/./,function(c){m=m+c.charCodeAt(0)&255})  // before
eval(x.replace(/./,'m=m+"$&".charCodeAt(0)&255;'))   // after
```

Booleans
--------
### Use `!` to create booleans

`true` and `false` can be created by combining the `!` operator with numbers.

```javascript
[true,false] // before
[!0,!1]      // after
```

Boolean coercion can be useful, too. If coerced to Number (e.g. by prefixing a +), true will coerce to 1, false to 0. So a program that will test one condition to output 2 and another one to output 1 and 0 if none is met, can be reduced:

```javascript
x>7?2:x>4?1:0 // before
+(x>7)+(x>4)  // after
```

One way that minifiers are able to shave bytes off of JavaScript code is changing the way booleans are used, from David Walsh [blog](http://davidwalsh.name/javascript-booleans):

```javascript
true === !0 // before, save 2 chars
false === !1 // after, save 3 chars
```

Functions
---------
### Shorten function names

Assign prototype functions to short variables. This may also be faster in more complex cases.
```javascript
a=Math.random(),b=Math.random() // before
r=Math.random;a=r(),b=r()       // after
```

### Use named functions for recursion

Recursion is often more terse than looping, because it offloads bookkeeping to the stack. This is used in @jed's [walk](https://gist.github.com/964769) function.

### Use named functions for saving state

If state needs to be saved between function calls, name the function and use it as a container. This is used for a counter in @jed's [JSONP](https://gist.github.com/962814) function.

```javascript
function(i){return function(){console.log("called "+(++i)+" times")}}(0) // before
(function a(){console.log("called "+(a.i=-~a.i)+" times")})           // after
0,function a(){console.log("called "+(a.i=-~a.i)+" times")}           // another alternative
```

### Omit `()` on `new` calls w/o arguments

`new Object` is equivalent to `new Object()`

```javascript
now = +new Date() // before
now = +new Date   // after
```

### Omit the `new` keyword when possible

Some constructors don't actually require the `new` keyword.

```javascript
r=new Regexp(".",g) // before
r=Regexp(".",g)     // after

l=new Function("x","console.log(x)") // before
l=Function("x","console.log(x)")     // after
```

### The `return` statement

When returning anything but a variable, there’s no need to use a space after `return`:

```js
return ['foo',42,'bar']; // before
return['foo',42,'bar'];  // after
return {x:42,y:417}; // before
return{x:42,y:417};  // after
return .01; // before
return.01;  // after
```

### Use the right closure for the job

If you need to execute a function instantly, use the most appropriate closure.

```javascript
;(function(){...})() // before
new function(){...}  // after, if you plan on returning an object and can use `this`
!function(){...}()   // after, if you don't need to return anything
```

In the browser
------------
### Use browser objects to avoid logic

Instead of writing your own logic, you can use browser anchor elements to parse URLs as in @jed's [parseURL](https://gist.github.com/964849), and text nodes to escape HTML as in @eligrey's [escapeHTML](https://gist.github.com/eligrey/1224209).

### Use global scope

Since `window` is the global object in a browser, you can directly reference any property of it. This is well known for things like `document` and `location`, but it's also useful for other properties like `innerWidth`, as shown in @bmiedlar's [screensaver](https://gist.github.com/981915).

Delimiters
----------

Only use `;` where necessary. Encapsulate in other statements if possible, e.g.

```javascript
x=this;a=[].slice.call(arguments,1);
a=[x=this].slice.call(arguments,1);
```

APIs
----
### Pass static data via argument where possible

### Use extra bytes to provide default values

### Do one thing and do it well

Additional JavaScript Byte-saving Techniques
--------------------------------------------
- Names of global objects (`window`, `document`) and of frequently used
  fields/methods are stored in variables to make access shorter.
- Instead of `document.getElementById(...)`, use the fact that element IDs are
  also registered on the `window` object: `window[...]`.
- Because `var` declarations are costly, do them only once at the top-level
  scope, and reuse variables as much as possible. This does make it difficult
  to safely invoke functions.
- Inline as many functions as possible, because `function` is an awfully long
  word that cannot be shortened.
- Let `undefined` be the desired initial value of variables as much as
  possible, so we don't need to initialize them.
- Be aware of the `for(i in a)` syntax as an alternative to `for(i=0;i<n;i++)`.
  However, this isn't always shorter, because the traditional `for` loop lets
  you put more stuff inside the initialization, condition and increment part.
- Put assignments inside expressions where possible: instead of `x++;y=2*x`
  write `y=2*x++`.
- Instead of `x>=0&&x<4`, write `!(x&~3)`. This works even if `x` is negative.
- Use `~~(a+b)` instead of `Math.floor(a+b)` to cast to integer. `0|(a+b)` also
  works.
- For somewhat arbitrary constants, `9` is better than `10`, `99` better than
  `100`.
- `switch`/`case` is extremely verbose, especially if you need `break` (i.e.
  almost always). Just use `if`/`else if` instead.
- There is even one `goto`-like label, to `break` out of two `for` loops at the
  same time. This is the only thing labels in JavaScript can be used for.

Other resources
---------------
* [tis](https://github.com/ttencate/tis) An embeddable Tetris clone without dependencies in 4 kB of JavaScript
* [UglifyJS2](https://github.com/mishoo/UglifyJS2) a JavaScript parser, minifier, compressor or beautifier toolkit
* [SameGame](https://github.com/kadirpekel/samegame) a game submitted for js1k 2010 contest
* [Ben Alman](http://twitter.com/cowboy)'s explanation of his [JS1K entry](http://benalman.com/news/2010/08/organ1k-js1k-contest-entry/)
* [Marijn Haverbeke](http://twitter.com/marijnjh)'s explanation of his [JS1K entry](http://marijnhaverbeke.nl/js1k/)
* [Martin Kleppe](http://www.twitter.com/aemkei)'s presentation about his [140byt.es and JS1K entries](http://go.ubilabs.net/froscon)
* [Suggested Closure Compiler optimizations](http://code.google.com/p/closure-compiler/issues/detail?id=36)
* [Angus Croll](http://www.twitter.com/angusTweets)'s [blog](http://javascriptweblog.wordpress.com/)
* [Aivo Paas](http://www.twitter.com/aivopaas)'s [jscrush](http://iteral.com/jscrush/)
* [Cody Brocious](http://www.twitter.com/daeken)'s post on [superpacking JS demos](http://daeken.com/superpacking-js-demos)
