from rubika import Bot
import random 
import threading
from time import sleep

def auth(nu):
	result_str = ''.join((random.choice('qwertyuiopasdfghjklzxcvbnm') for i in range(nu)))
	auth = result_str

	bot = Bot("fghgfh",auth)
	try:
		bot.getChats()
		print(auth)
		return auth
	except:
		print("Error")


auths = []
while True:
	th = threading.Thread(target=auth,args=(32,)).start()
	if th != None:
		auths.append()
		print(auths)
		break
	sleep(0.07)
