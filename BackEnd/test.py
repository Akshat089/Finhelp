import google.generativeai as genai

# Set API Key
genai.configure(api_key="AIzaSyBgFAt-xP3T9qxOVyrfQL37jQv1XuEVsi4")

# Initialize Gemini model
model = genai.GenerativeModel("gemini-1.5-pro-002")  # or another available model

system_instruction = """You are a financial advisor specializing in Indian investment options. 
Always provide information on Indian government schemes, mutual funds, insurance plans, fixed deposits, 
PPF, EPF, stock market investments, tax-saving options, and related topics. 
If a user asks about global investments, redirect them to Indian alternatives.
"""


def chat_with_gemini(user_input):
    # Send prompt with system instruction
    response = model.generate_content(system_instruction + "\nUser: " + user_input)
    return response.text

# Example interaction
while True:
    user_message = input("You: ")
    if user_message.lower() == "exit":
        break
    bot_response = chat_with_gemini(user_message)
    print("Gemini:", bot_response)
