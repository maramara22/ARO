param location string
param spokeVnetName string
param spokeVnetCidr string
param controlPlaneSubnetCidr string
param computeSubnetCidr string
param tags object
param controlPlaneSubnetName string
param computeSubnetName string

resource cluster_vnet 'Microsoft.Network/virtualNetworks@2020-05-01' = {
  name: spokeVnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        spokeVnetCidr
      ]
    }
    subnets: [
      {
        name: controlPlaneSubnetName
        properties: {
          addressPrefix: controlPlaneSubnetCidr
          serviceEndpoints: [ { service: 'Microsoft.ContainerRegistry' } ]
          privateLinkServiceNetworkPolicies: 'Disabled'
        }
      }
      {
        name: computeSubnetName
        properties: {
          addressPrefix: computeSubnetCidr
          serviceEndpoints: [ { service: 'Microsoft.ContainerRegistry' } ]
        }
      }
    ]
  }
}
