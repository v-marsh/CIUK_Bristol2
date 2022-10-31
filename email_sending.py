import smtplib
import email.message


def send_email(subject, msg):
    try:
        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.ehlo()
        server.starttls()
        server.ehlo()
        ID = 'ciukbristol@gmail.com'
        PASSWORD = 'qbedossupcdieyqe'
        email_reciever = 'yn19865@bristol.ac.uk'
        server.login(ID, PASSWORD)
        message = 'Subject:{} \n\n {}'.format(subject, msg)
        server.sendmail(ID, email_reciever, message)

    finally:
        server.quit()


filename = r"benchmark.txt" #### FILE NAME GOES HERE
with open(filename, "r") as filename:
    text = filename.read()
msg = email.message.Message()
msg.add_header('Content-Type', 'text/plain')
msg.set_payload(text)

subject = "Report"

send_email(subject, msg)
