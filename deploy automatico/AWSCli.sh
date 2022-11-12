#!/bin/sh

echo  crear infraestructura laboratorio 
#Variables
staterun="running"
number=2

#Borrado de llaves cloud y local
echo 1.  borrar par de llaves 
aws ec2 delete-key-pair --key-name edwinKeyPair
rm edwinKeyPair.pem

echo 2.  crear nuevo par de llaves 
aws ec2 create-key-pair --key-name edwinKeyPair --query 'KeyMaterial' --output text > edwinKeyPair.pem

chmod 600 edwinKeyPair.pem

#Pasos para crear VPC y redes publicas 
echo 3.  crear vpc 
idVPC=$(aws ec2 create-vpc --cidr-block 10.0.0.0/16 --query Vpc.VpcId --output text)

echo 4.  crear sub redes 
aws ec2 create-subnet --vpc-id "$idVPC" --cidr-block 10.0.1.0/24 --output text
aws ec2 create-subnet --vpc-id "$idVPC" --cidr-block 10.0.0.0/24 --output text

echo 5.  crear Gateway 
idGateway=$(aws ec2 create-internet-gateway --query InternetGateway.InternetGatewayId --output text)
aws ec2 attach-internet-gateway --vpc-id "$idVPC" --internet-gateway-id "$idGateway"

echo 6.  crear una ruta con todo trafico 
idRtb=$(aws ec2 create-route-table --vpc-id "$idVPC" --query RouteTable.RouteTableId --output text)

echo 7.  crear tabla de ruteo 
aws ec2 create-route --route-table-id "$idRtb" --destination-cidr-block 0.0.0.0/0 --gateway-id "$idGateway"

aws ec2 describe-route-tables --route-table-id "$idRtb" --output text

echo 8.  asignar sub red  taba de ruteo 
idSubRed=$(aws ec2 describe-subnets --filters "Name=vpc-id","Values='$idVPC'" --query "Subnets[0].{ID:SubnetId}" --output text)
aws ec2 associate-route-table  --subnet-id "$idSubRed" --route-table-id "$idRtb"
aws ec2 modify-subnet-attribute --subnet-id "$idSubRed" --map-public-ip-on-launch

echo 9.  crear security group 
aws ec2 create-security-group --group-name my-sg-cli --description "Test Security Group" --vpc-id "$idVPC"
idgroup=$(aws ec2 describe-security-groups --filters Name=group-name,Values=my-sg-cli --query "SecurityGroups[*].{ID:GroupId}" --output text)

echo 10.  crear una regla de trafico tcp en grupo de seguridad 
aws ec2 authorize-security-group-ingress --group-id "$idgroup" --protocol tcp --port 22 --cidr 0.0.0.0/0

echo 11.  crear inatancias 
aws ec2 run-instances --image-id ami-a4827dc9 --count 1 --instance-type t2.micro --key-name edwinKeyPair --security-group-ids "$idgroup" --subnet-id "$idSubRed" --tag-specifications 'ResourceType=instance,Tags=[{Key=NameInstance,Value=Instance1}]' --output text
aws ec2 run-instances --image-id ami-a4827dc9 --count 1 --instance-type t2.micro --key-name edwinKeyPair --security-group-ids "$idgroup" --subnet-id "$idSubRed" --tag-specifications 'ResourceType=instance,Tags=[{Key=NameInstance,Value=Instance2}]' --output text
aws ec2 run-instances --image-id ami-a4827dc9 --count 1 --instance-type t2.micro --key-name edwinKeyPair --security-group-ids "$idgroup" --subnet-id "$idSubRed" --tag-specifications 'ResourceType=instance,Tags=[{Key=NameInstance,Value=Instance3}]' --output text

#capturar id de las instancias
id_instancia_1=$(aws ec2 describe-instances --filters "Name=tag:NameInstance,Values=Instance1" "Name=instance-state-name,Values=pending"  --query "Reservations[].Instances[].InstanceId" --output text)
id_instancia_2=$(aws ec2 describe-instances --filters "Name=tag:NameInstance,Values=Instance2" "Name=instance-state-name,Values=pending"  --query "Reservations[].Instances[].InstanceId" --output text)
id_instancia_3=$(aws ec2 describe-instances --filters "Name=tag:NameInstance,Values=Instance3" "Name=instance-state-name,Values=pending"  --query "Reservations[].Instances[].InstanceId" --output text)

#capturar el estado de las instancias
id_state_1=$(aws ec2 describe-instances --instance-id "$id_instancia_1" --query "Reservations[*].Instances[*].{State:State.Name}" --output text)
id_state_2=$(aws ec2 describe-instances --instance-id "$id_instancia_2" --query "Reservations[*].Instances[*].{State:State.Name}" --output text)
id_state_3=$(aws ec2 describe-instances --instance-id "$id_instancia_3" --query "Reservations[*].Instances[*].{State:State.Name}" --output text)


# validar que las instancias esten en estado running
while [ $number -gt 1 ]
do
echo 11.  vallidando estado 
if [[ $id_state_1 = $staterun ]] && [[ $id_state_2 = $staterun ]] && [[ $id_state_3 = $staterun ]]
then
   number=$(($number-1))
else
	echo "Validación de estado"
    id_state_1=$(aws ec2 describe-instances --instance-id "$id_instancia_1" --query "Reservations[].Instances[].{State:State.Name}" --output text)
	id_state_2=$(aws ec2 describe-instances --instance-id "$id_instancia_2" --query "Reservations[].Instances[].{State:State.Name}" --output text)
	id_state_3=$(aws ec2 describe-instances --instance-id "$id_instancia_3" --query "Reservations[].Instances[].{State:State.Name}" --output text)
fi

echo 11.  capturar ip publicas 
id_ip_1=$(aws ec2 describe-instances --instance-id "$id_instancia_1" --query "Reservations[*].Instances[*].{Address:PublicIpAddress}" --output text)
id_ip_2=$(aws ec2 describe-instances --instance-id "$id_instancia_2" --query "Reservations[*].Instances[*].{Address:PublicIpAddress}" --output text)
id_ip_3=$(aws ec2 describe-instances --instance-id "$id_instancia_3" --query "Reservations[*].Instances[*].{Address:PublicIpAddress}" --output text)

echo  instancias ok 