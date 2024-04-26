package com.example.messages

import androidx.annotation.NonNull

import io.bloco.faker.Faker

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

import MessageDto
import MessagingApi
import android.util.Log

class MainActivity: FlutterActivity(), MessagingApi {
    private val faker = Faker("pt-BR")

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MessagingApi.setUp(flutterEngine.dartExecutor.binaryMessenger, this)
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