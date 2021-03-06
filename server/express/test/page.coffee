page = require '../lib/page.coffee'
path = require('path')
random = require('../lib/random_id')
testid = random()
argv = require('../lib/defaultargs.coffee')({d: path.join('/tmp', 'sfwtests', testid)})

testpage = {title: 'Asdf'}

describe 'page', ->
  before ->
    page.setup(argv)
  describe '#page.put()', ->
    it 'should save a page', (done) ->
      page.put('asdf', testpage, (e) ->
        done(e)
      )
  describe '#page.get()', ->
    it 'should get a page if it exists', (done) ->
      page.get('asdf', (got) ->
        got.title.should.equal 'Asdf'
        done()
      )
    it 'should copy a page from default if nonexistant in db', (done) ->
      page.get('welcome-visitors', (got) ->
        got.title.should.equal 'Welcome Visitors'
        done()
      )
    it 'should create a page if it exists nowhere', (done) ->
      page.get(random(), (got) ->
        got.story.length.should.equal 1
        got.story[0].type.should.equal 'factory'
        done()
      )
