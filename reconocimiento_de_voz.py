import pyaudio
import speech_recognition as sr
r = sr.Recognizer()
with sr.Microphone() as source:
    print("Di algo:")
    audio = r.listen(source)
    try:
        text = r.recognize_google(audio,language = "es-MX")
        print("Lo que dijiste fue : {}".format(text))
    except:
        print("Lo siento, no se entendió lo que dijiste")