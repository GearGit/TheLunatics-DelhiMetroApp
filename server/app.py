import socket
import sys
import threading

import firebase_admin
from firebase_admin import credentials,firestore

cred=credentials.Certificate('key.json')
default_app=firebase_admin.initialize_app(cred)
intersec={"y":["m13,14","b22,22"],"m":["y14,13","b01,09"],"b":["m09,01","y22,22"]}

def start_server():
       
   #  gets ip address of the local machine
   host = socket.gethostbyname(socket.gethostname())    
   print(host)
   port = 8080
   soc = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
   print("Socket created")

   try:

      # binds the socket to the ip and port
      
      soc.bind((host, port))                     
   except:
      print("Bind failed. Error : " + str(sys.exc_info()))
      sys.exit()

   soc.listen(10)
   print("Socket now listening")
   
   while True:
          
         #  waits for an incoming connection from the client

      connection, address = soc.accept()               
      ip, port = str(address[0]), str(address[1])
      print("Connected with " + ip + ":" + port+'\n')

      # creates a new thread for each new client

      threading.Thread(target=clientThread, args=(connection, ip, port)).start()     
      
def clientThread(connection, ip, port, max_buffer_size = 12):

   is_active = True
   db=firestore.client()

   while is_active:
          
      # waits for input from the client

      client_input = connection.recv(max_buffer_size).decode('utf-8')        
      print(client_input)
      temp=client_input.split(",")
      if temp[0][0]==temp[1][0]:
         a=ticket_book(client_input,db)
      else:
         a=intersection_station(client_input,db)

      if not client_input:
         print("Client has quit")
         connection.close()
         print("Connection " + ip + ":" + port + " closed")
         is_active = False
      else:
         print(a)
         connection.send(a.encode("utf8"))
         
# checks seat availability between 2 stations 

def ticket_book(s,db):                         

    dic={"y":"yellow","m":"megenta","b":"blue"}
    l=s.split(",")

    doc_ref = db.collection(dic[l[0][0]]).document(l[0])

    if int(l[1][1:])-int(l[0][1:])>0:
        direction="forward"
        z="lst"
        h=0
    else:
        direction='backward'
        z="lst1"
        h=1

    tm=doc_ref.get().to_dict()[l[2]][h]
    print(tm,direction)

    doc_ref=db.collection(dic[l[0][0]]).document(tm)

    train=doc_ref.get().to_dict()[direction][0][z]
    
    if direction=="forward":
       if 144 not in train[int(l[0][1:])-1:int(l[1][1:])] and train[int(l[0][1:])-1]<50:
          for i in range(int(l[0][1:])-1,int(l[1][1:])-1):
             train[i] = train[i]+1
       else:
          return 'no'
    else:
       if 144 not in train[len(train)-int(l[0][1:]):len(train)-int(l[1][1:])+1] and train[len(train)-int(l[1][1:])]<50:
          for i in range(len(train)-int(l[0][1:]),len(train)-int(l[1][1:])):
             train[i] = train[i]+1
       else:
          return 'no'
    doc_ref.update({direction:[{z:train},144]})

    return 'yes'

# deals with situations where line changing is required

def intersection_station(s,db):               
   global intersec
   l=s.split(",")
   w=[]
   for i in intersec[l[0][0]]:
      s=[l[0],l[0][0]+i[1:3],l[2]]
      stno=abs(int(l[0][1:])-int(i[1:3]))+1
      if l[1][0]==i[0]:
         t=duration_calculator(s)
         stno=stno+abs(int(i[4:])-int(l[1][1:]))
         w.append([stno,s,[i[0]+i[4:],l[1],t]])
      else:
         temp=[k[0] for k in intersec[i[0]]]
         if l[1][0] in temp:
            st=intersec[i[0]][temp.index(l[1][0])]
            t=duration_calculator(s)
            stno=stno+abs(int(i[4:])-int(st[1:3]))
            ls1=[i[0]+i[4:],i[0]+st[1:3],t]
            stno=stno+abs(int(st[4:])-int(l[1][1:]))
            t1=duration_calculator(ls1)
            w.append([stno,s,ls1,[st[0]+st[4:],l[1],t1]])
                          
   w.sort(key=takefirst)
   for j in range(len(w)):
      print(w[j])
      if j==2 and abs(w[j][0]-w[j-1][0])>8:
         return 'no'
      else:
         for h in w[j][1:]: 
            a=ticket_book(",".join(h),db)
            if a=="no":
               if j<len(w)-1:
                  break
               else:
                  return "no"
         if a=="yes":
            rt=[]
            for x in w[j][1:len(w[j])-1]:
               rt.append(x[1])
            return "yes,"+",".join(rt)
               
# used for computing arrival time at the intersection station

def duration_calculator(l):                           
   t=abs(int(l[0][1:])-int(l[1][1:]))*5+5
   t1=int(l[2][0:2])*60+int(l[2][2:])
   tf=t+t1
   h=str(tf//60)
   if len(h)==1:
      h="0"+h
   m=str(tf%60)
   if len(m)==1:
      m="0"+m
   return h+m

def takefirst(elem):
    return elem[0]
                  
start_server()