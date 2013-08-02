Hasher
======

Coffeescript hashchanger with some features. Works with # url

init

window.marine = new Hasher

How to GET

sports_array = marine.get('sports')

/#sports=1,2,3,4,5 => sports_array == [1,2,3,4,5]

/#sports=1  => sports_array == [1]

/ => sports_array == false

How to SET

Was /some

window.marine.set('sports',[1,2,3])  => /some#sports=1,2,3

window.marine.set('event',12345) => /some#sports=1,2,3&event=12345

window.marine.set('sports',[1,3,4],'event') => /some#sports=1,3,4

How to Clear

window.marine.clear() ==> /some#

How to handle event?

If url hash changes with Hasher - I'll ignore it
If url hash changes with copy-past,browser button => I will reload page

PROBLEMS

1. Using global variable window.itsnothasher  for understanding - it's me, or not me
2. Using local class function for onhashchange == window.location.reload
3. You couldn't set more than one key in one set. Only set one key & remove one key
