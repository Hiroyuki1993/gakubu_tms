import lvm_read
import numpy as np

fname = "./data_demo/LFDI.lvm"
lvm = lvm_read.read(fname)
mat = []
for i in range(lvm['Segments']):
    mat.append(np.array(lvm[i]['data'])[:,0])
mat = np.array(mat).T
np.savetxt(fname[0:-3]+"csv", mat[:,0:], delimiter=",")
