package com.example.messages

import androidx.annotation.NonNull

import io.bloco.faker.Faker

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.Log

import FlutterMessagingApi
import MessagingApi
import MessageDto

class MainActivity: FlutterActivity(), MessagingApi {
    private val faker = Faker("pt-BR")

    private lateinit var flutterApi: FlutterMessagingApi;

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val binaryMessenger = flutterEngine.dartExecutor.binaryMessenger

        MessagingApi.setUp(binaryMessenger, this)
        this.flutterApi = FlutterMessagingApi(binaryMessenger)
    }

    private fun createMessage(message: String, isOwner: Boolean = false) : MessageDto {
        val date = faker.date.forward().toString()
        val name =  if(isOwner) "Você" else faker.name.firstName();
        val id = if(isOwner) "01" else faker.number.between(2, 10).toString()

        return MessageDto(id,name,message,date)
    }

    override fun getMessages(): List<MessageDto> {
        return listOf(
            createMessage("Olá, como vai?"),
            createMessage("Eu estou bem, obrigado!", isOwner = true),
            createMessage("O que você está fazendo?"),
        )
    }

    override fun sendMessage(message: MessageDto): MessageDto {
        Log.i("MessageDto", "Send message: ${message.toString()}")
        return createMessage(faker.lorem.sentence())
    }
}