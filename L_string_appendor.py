1#legit = 0 
#cft = 1
#pre = input('Press 1 for CFT or 0 for LEGIT:   ')
pre = 'L'
prefix = pre + ','
suffix = ''

print("You are appending " +pre+ "'s to the beginning of each line.")

#-------------------------------------------------------------
#*************************************************************
#insert file name here... make sure it belongs in the same directory


file = input('Paste name of file here: ') 


#*************************************************************
#-------------------------------------------------------------


#-------------------------------------------------------------


with open(file +'.csv', 'r') as src:
    with open(file + '_appended_' +pre+ '.csv', 'w') as dest:
       for line in src:
           dest.write('%s%s%s\n' % (prefix, line.rstrip('\n'), suffix))
           
           
           
#-------------------------------------------------------------
           
#-------------------------------------------------------------   


print ("""\nHello Python User! \n\nYou decided to append file: """ + file + """  
\n...please check to see if the file uploaded just fine.""")


#-------------------------------------------------------------        
