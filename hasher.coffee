typeIsArray = Array.isArray || ( value ) -> return {}.toString.call( value ) is '[object Array]'

class Hasher
    @params : {}
    func : () =>
        do window.location.reload
        return
    constructor: () ->
        window.itsnothasher = true
        do @load
        window.onhashchange = () =>
            if window.itsnothasher
                do @load
                do @func
            else
                window.itsnothasher = true    
            return
    set: (key,value,removekey = null) ->
        if key? and value?
          do @load
          if typeIsArray value
              result = []
              for k,v of value
                z = parseInt(v,10)
                if (z+'') == v
                  result.push z
              value = result.join()
          else
              if _.isNumber value
                value = escape(value)
          @params[key] = value
          if @params?[removekey]?
            delete @params[removekey]
          do @push
    clear: () ->
        @params = {}
        window.itsnothasher = false
        window.location.hash = null
    remove: (key,value) ->
        if @params?[key]?
            delete @params[key]
            do @push
    get: (key,integer = true) ->
        if @params?[key]?
            if typeof @params[key] is "string"
                returnarray = @params[key].split(",")
            else
                returnarray = @params[key]
            if integer
                result = []
                for v in returnarray
                    result.push parseInt(v,10)
                return result
            else
                return returnarray
        else 
            false
    keyExists: (key) ->
        @params.hasOwnProperty(key)
    push: () ->
        hashBuilder = [] 
        for key,val of @params
            if @params.hasOwnProperty(key)
                key = escape(key)
                value = @params[key]
                if value != "undefined"
                    hashBuilder.push(key+'='+value)
        if window.location.hash != '#'+hashBuilder.join("&")
          window.itsnothasher = false
          window.location.hash = hashBuilder.join("&")
    load: () ->
        @params = {}
        if window.location.hash
            hashStr = window.location.hash
            hashStr = hashStr.substring(1, hashStr.length)
            hashArray = hashStr.split('&')            
            for i in [0...hashArray.length]
                keyVal = hashArray[i].split('=')
                @params[unescape(keyVal[0])] = (if (typeof keyVal[1] != "undefined") then unescape(keyVal[1]) else keyVal[1])
