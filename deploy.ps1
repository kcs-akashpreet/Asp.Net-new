# get the VMSS model

$vmss = Get-AzureRmVmss -ResourceGroupName Support-POC -VMScaleSetName vmssakash

# set the new version in the model data

$vmss.virtualMachineProfile.storageProfile.osDisk.image.uri="$(bakedImageUrl)"

# update the virtual machine scale set model

Update-AzureRmVmss -ResourceGroupName kcs-tst -Name kcs-tst -VirtualMachineScaleSet $vmss
