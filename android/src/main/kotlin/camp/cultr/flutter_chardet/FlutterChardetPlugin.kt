package camp.cultr.flutter_chardet

import androidx.annotation.NonNull

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import org.mozilla.universalchardet.UniversalDetector
import java.nio.ByteBuffer
import java.nio.charset.Charset
import java.nio.charset.IllegalCharsetNameException
import java.nio.charset.UnsupportedCharsetException

/** FlutterChardetPlugin */
class FlutterChardetPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "flutter_chardet")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
    when(call.method) {
      "autoDecode" -> handleAutoDecode(call, result)
      "detect" -> handleDetect(call, result)
      else -> result.notImplemented()
    }
  }

  private fun handleAutoDecode(call: MethodCall, result: Result) {
    val data = call.argument<ByteArray>("data")
    if (data == null) {
      result.error("MissingArg", "Required argument missing", "${call.method} requires 'data'")
      return
    }
    val charsetName = data.inputStream().use(UniversalDetector::detectCharset)
    if (charsetName == null) {
      result.error("DetectionFailed", "The charset could not be detected", null)
      return
    }
    val charset: Charset = try {
      Charset.forName(charsetName)
    } catch (e: Exception) {
      when (e) {
        is IllegalCharsetNameException,
        is UnsupportedCharsetException -> {
          result.error("UnsupportedCharset", "The detected charset $charsetName is not supported.", null)
          return
        }
        else -> throw e
      }
    }
    val string = charset.decode(ByteBuffer.wrap(data)).toString()
    result.success(
      mapOf(
        "charset" to charsetName,
        "string" to string
      )
    )
  }

  private fun handleDetect(call: MethodCall, result: Result) {
    val data = call.argument<ByteArray>("data")
    if (data == null) {
      result.error("MissingArg", "Required argument missing", "${call.method} requires 'data'")
      return
    }
    val charsetName = data.inputStream().use(UniversalDetector::detectCharset)
    if (charsetName == null) {
      result.error("DetectionFailed", "The charset could not be detected", null)
      return
    }
    result.success(charsetName)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
