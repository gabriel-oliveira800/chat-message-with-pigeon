package com.example.messages

import androidx.annotation.NonNull

import io.bloco.faker.Faker

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodCall


class MainActivity: FlutterActivity(), MethodCallHandler {
    private val faker = Faker("pt-BR")
    private lateinit var channel: MethodChannel

    private val CHANNEL = "cubos.dev.message/service"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        channel = MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
        this.channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getMessages" -> getMessages(result)
            "sendMessage" ->  sendMessage(result)
            else -> result.notImplemented()
        }
    }

    private fun getMessages(result: Result) {
        val messages = listOf(
            "Olá, como vai?",
            "[OWNER]: Eu estou bem, obrigado!",
            "O que você está fazendo?",
        )

        result.success(messages)
    }

    private fun sendMessage(result: Result) {
        var message = HashMap<String, String>()

        message["name"] = faker.name.firstName()
        message["message"] = faker.lorem.sentence()

        result.success(message)
    }
}