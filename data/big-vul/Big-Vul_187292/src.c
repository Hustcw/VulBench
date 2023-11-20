CastStreamingNativeHandler::CastStreamingNativeHandler(ScriptContext* context)
     : ObjectBackedNativeHandler(context),
       last_transport_id_(1),
       weak_factory_(this) {
  RouteFunction("CreateSession",
                 base::Bind(&CastStreamingNativeHandler::CreateCastSession,
                            weak_factory_.GetWeakPtr()));
  RouteFunction("DestroyCastRtpStream",
                 base::Bind(&CastStreamingNativeHandler::DestroyCastRtpStream,
                            weak_factory_.GetWeakPtr()));
   RouteFunction(
      "GetSupportedParamsCastRtpStream",
       base::Bind(&CastStreamingNativeHandler::GetSupportedParamsCastRtpStream,
                  weak_factory_.GetWeakPtr()));
  RouteFunction("StartCastRtpStream",
                 base::Bind(&CastStreamingNativeHandler::StartCastRtpStream,
                            weak_factory_.GetWeakPtr()));
  RouteFunction("StopCastRtpStream",
                 base::Bind(&CastStreamingNativeHandler::StopCastRtpStream,
                            weak_factory_.GetWeakPtr()));
  RouteFunction("DestroyCastUdpTransport",
                 base::Bind(&CastStreamingNativeHandler::DestroyCastUdpTransport,
                            weak_factory_.GetWeakPtr()));
   RouteFunction(
      "SetDestinationCastUdpTransport",
       base::Bind(&CastStreamingNativeHandler::SetDestinationCastUdpTransport,
                  weak_factory_.GetWeakPtr()));
   RouteFunction(
      "SetOptionsCastUdpTransport",
       base::Bind(&CastStreamingNativeHandler::SetOptionsCastUdpTransport,
                  weak_factory_.GetWeakPtr()));
  RouteFunction("ToggleLogging",
                 base::Bind(&CastStreamingNativeHandler::ToggleLogging,
                            weak_factory_.GetWeakPtr()));
  RouteFunction("GetRawEvents",
                 base::Bind(&CastStreamingNativeHandler::GetRawEvents,
                            weak_factory_.GetWeakPtr()));
  RouteFunction("GetStats", base::Bind(&CastStreamingNativeHandler::GetStats,
                                       weak_factory_.GetWeakPtr()));
  RouteFunction("StartCastRtpReceiver",
                 base::Bind(&CastStreamingNativeHandler::StartCastRtpReceiver,
                            weak_factory_.GetWeakPtr()));
 }
