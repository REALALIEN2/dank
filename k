pip install discord.py
pip install requests
import discord
import requests
import asyncio

client = discord.Client(915064287943340105)

@client.event
async def on_ready():
    print('Logged in as {0.user}'.format(client))

@client.event
async def on_message(message):
    if message.author == client.user:
        return

    if message.content.startswith('!remindme'):
        # Get the current user's ID
        user_id = message.author.id
        
        # Get the cooldown time for the money command
        response = requests.get('https://api.tovade.xyz/dmcooldowns/' + str(user_id))
        if response.status_code == 200:
            data = response.json()
            if 'money' in data:
                money_cooldown = data['money']
                minutes = money_cooldown // 60
                seconds = money_cooldown % 60
                await message.channel.send(f'Your money command will be available in {minutes} minutes and {seconds} seconds.')
            else:
                await message.channel.send('You haven\'t used the money command yet!')
        else:
            await message.channel.send('There was an error getting your cooldowns.')

client.run('OTE1MDY0Mjg3OTQzMzQwMTA1.G4ZKET.x9oGf8b0HGFYnY3pM0C3zySv0OwskANOxt89Ho')
