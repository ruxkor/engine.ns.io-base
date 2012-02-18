extendEngine = (engine) ->
    # modify engine protocol: add -ns
    engine.protocol = engine.protocol+'-ns'

    # use JSON as serializer
    engine.Socket.prototype.ns_serialize = JSON.stringify
    engine.Socket.prototype.ns_unserialize = JSON.parse

    # events the socket should not emit because the events are already
    # being used by the engine logic
    engine.Socket.prototype.ns_reserved_events = ['open','close','message','raw']

    # prefix used for events that would be emitted as a reserved token
    engine.Socket.prototype.ns_prefix = 'ns:'

    ###
    # send_raw is equivalent to engine.io's Socket.send
    #
    # @api public
    #
    ###
    engine.Socket.prototype.send_raw = engine.Socket.prototype.send

    ###
    # don't use the send function, use send_raw or send_ns
    # @api private
    #
    # @throws Exception
    #
    ###
    engine.Socket.prototype.send = () ->
        throw "use send_ns or send_raw"

    ###
    # sends an object, adding a namespace to it
    #
    # @api public
    #
    ###
    engine.Socket.prototype.send_ns = (ns,data) ->
        @send_raw 'ns:'+@ns_serialize([ns,data])

    ###
    # onmessage handler for ns messages
    #
    # checks if messages start with a ns token and if yes
    # unserializes the data and emits a custom event based on the
    # namespace
    #
    # @api private
    # 
    ###
    engine.Socket.prototype.onmessage = (message) ->
        if message[0...3] == 'ns:'
            [ns,data] = @ns_unserialize message[3...]
            @emit(
                if ns in @ns_reserved_events then @ns_prefix_for_reserved+ns else ns,
                data
            )
        else
            @emit 'raw', message

exports.extendEngine = extendEngine
