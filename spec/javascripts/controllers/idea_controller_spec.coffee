describe 'Actionman', ()->

  beforeEach(module('Actionman'))

  describe 'IdeaCtrl', () -> 
    ideaData = { 
      description: 'Body language affects how others see us, but it may also change how we see ourselves.',
      action: ['action1', 'action2']
      talks: [{title: "The talk"}, {title: "The other talk"}]
    }

    scope = null
    ctrl = null
    $httpBackend = null

    beforeEach inject (_$httpBackend_, $rootScope, $controller, $cacheFactory, $navigate) ->
      $httpBackend = _$httpBackend_

      window.ENDPOINT = 'window_endpoint'

      $httpBackend.expectGET("#{window.ENDPOINT}/ideas/1.json").
            respond(ideaData)
      $httpBackend.expectGET("#{window.ENDPOINT}/ideas/1/show_idea_url").
            respond({idea_url: "http://bit.ly/15z4CPz"})


      $navigate.swipeScope = { name: "mock swipe scope", refreshPageHeight: jasmine.createSpy('refreshPageHeight') }

      scope = $rootScope.$new()
      ctrl = $controller( 'IdeaCtrl', { $scope: scope, $routeParams: { ideaId: 1 }, dataCache: $cacheFactory('fake cache'), $navigate })


    describe "#update", ()->

      it 'should set the ideaId correctly', () ->
        scope.update()
        $httpBackend.flush()
        expect(scope.ideaId).toEqual(1);

      it 'should create "idea" model obtained restfully', () ->
        scope.update()
        expect(scope.idea).toBeUndefined()
        $httpBackend.flush()
        expect(scope.idea).toEqual(ideaData)

      it 'should generate a twitter url', () ->
        scope.update()
        expect(scope.twitter).toBeUndefined()
        $httpBackend.flush()
        expect(scope.twitter.url).toEqual("https://twitter.com/intent/tweet?original_referer=#{window.ENDPOINT}&text=#{scope.idea.talks[0].title}&tw_p=tweetbutton&url=#{scope.idea_short_url}")

      it 'should expose an update method', () ->
        scope.update()
        $httpBackend.flush()
        expect(scope.update).toBeDefined()

      it 'should execute a callback within update if one is given', () ->
        callback = jasmine.createSpy 'callback'
        scope.update(callback)
        $httpBackend.flush()
        expect(callback).toHaveBeenCalled()

