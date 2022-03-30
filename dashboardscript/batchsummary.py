# Python program to read
# json file


import json
import pandas as pd
from csvToJson import csv_to_json
d=pd.read_json('./merge/final.json');
#print(d)
#df = pd.DataFrame()
#print(d['Batch Name'])
#df = df.groupby(d['Batch Name'].agg(['count']))
#
df1=d['Batch Name'].value_counts().to_frame().reset_index()
df1.columns = ['Batch Name', 'Participant Count']
#print(df1.head())
#.to_csv("participants.csv")
df2=d[d['Certificate Status'] == 'Issued'].groupby('Batch Name')['Certificate Status'].value_counts().to_frame()
df2=df2.rename(columns={'Certificate Status':'Certificate Count'})
#print(df2.head())
#.to_csv("cert.csv")
df3=d[d['Progress'] == 100].groupby('Batch Name')['Progress'].value_counts().to_frame()
df3=df3.rename(columns={'Progress':'Completion Count'})
#df3.columns = ['Batch Name','Certificate Status','Certificate Count']
#print(df3.head())

#.to_csv("completed.csv")
#d['User Sub Type'].value_counts().to_csv("userSubType.csv")
df4=df1.merge(df3,on="Batch Name", how='left')
df5=df4.merge(df2,on="Batch Name", how='left')
#replace all NaN values with zeros
df5['Completion Count'] = df5['Completion Count'].fillna(0)
df5['Certificate Count'] = df5['Certificate Count'].fillna(0)

#convert 'rebounds' column from float to integer
df5['Completion Count'] = df5['Completion Count'].astype(int) 
df5['Certificate Count'] = df5['Certificate Count'].astype(int) 
df5.to_csv("./merge/batchsummary.csv",index=False);

csvFilePath = r'./merge/batchsummary.csv'
jsonFilePath = r'./merge/batchsummary.json'
csv_to_json(csvFilePath, jsonFilePath)


#print(df5)
#df1.to_frame()['Batch Name'] = df2.to_frame()['Batch Name'].astype(str)
#print(pd.concat([df1.to_frame(), df2.to_frame()], axis=1, sort=False))


# Opening JSON file
#f = open('final.json',)

# returns JSON object as
# a dictionary
#data = {'igot':''};
#data['igot'] = json.load(f)

# Iterating through the json
# list
#for i in data['igot']:
#	print(i)

# Closing file
#f.close()

