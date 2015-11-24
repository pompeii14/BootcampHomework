
# coding: utf-8

# In[1]:

import pandas as pd
import numpy as np


# In[27]:

walmart = pd.read_csv('train.csv')


# In[28]:

walmart.head()


# In[29]:

deptID = walmart[['DepartmentDescription', 'FinelineNumber']].apply(lambda x: '_'.join(map(str, x)), axis=1)


# In[30]:

wmt = walmart.drop('Upc', axis=1)


# In[31]:

wmt.head()


# In[32]:

wmt['DeptID'] = deptID


# In[33]:

wmt.head()


# In[34]:

wmt = wmt.drop(['DepartmentDescription', 'FinelineNumber'], axis=1)


# In[35]:

wmt.head()


# In[36]:

wmt.shape


# In[37]:

len(wmt)


# In[38]:

deptID.unique


# In[39]:

print wmt.groupby('DeptID').count


# In[40]:

len(pd.unique(deptID))


# In[41]:

deptList = pd.unique(deptID)


# In[42]:

len(deptList)


# In[43]:

wmt.head()


# In[50]:

wmtnew = wmt.copy()


# In[51]:

wmtnew.head()


# In[52]:

deptList


# In[77]:

wmtnew = wmt.copy()
wmtnew.head()


# In[78]:

for i in np.arange(len(deptList)):
    print "Creating Column (/10490): %s" %i
#     print "Current Dept: %s" %deptList[i]
    wmtnew[deptList[i]] = 0
    
for i in np.arange(len(wmtnew)):
    print "Setting Count (/647053): %s" %i
#     print "Dept: %s" %wmtnew['DeptID'][i]
#     print "Count: %s" %wmtnew['ScanCount'][i]
#     print "OLDCOUNT: %s" %wmtnew[wmtnew['DeptID'][i]][i]
    wmtnew[wmtnew['DeptID'][i]][i] = wmtnew['ScanCount'][i]
#     print "-"*70


# In[ ]:




# In[79]:

wmtnew.head()


# In[80]:

wmtnew = wmtnew.drop(['DeptID', 'ScanCount'], axis=1)


# In[81]:

wmtnew.head()


# In[82]:

wmtnew = wmtnew.groupby(['TripType', 'VisitNumber', 'Weekday']).sum()


# In[83]:

wmtnew.head()


# In[96]:

wmtnew = wmtnew.reset_index()


# In[97]:

wmtnew.head()


# In[99]:

wmtnew[wmtnew['VisitNumber'] == 7]


# In[100]:

wmtnew.to_csv('wmtnew.csv')


# In[ ]:



