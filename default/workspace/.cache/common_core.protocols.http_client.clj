(ns common-core.protocols.http-client
  (:require [schema.core :as s]))

(defprotocol HttpClient
  "Protocol for making HTTP requests (outbound)"
  (req! [component req-map] [component defaults req-map] "Make a request, optionally overriding the default request map")
  (warm-up! [component req-maps] "Pre compute any slow computation necessary to execute the requests listed on the req-maps"))

(def IHttpClient (s/protocol HttpClient))