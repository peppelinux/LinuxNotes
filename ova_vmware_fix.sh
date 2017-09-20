#!/bin/bash

FILENAME=$1
BASENAME=$(basename "$FILENAME" .ova)

echo "Extracting $FILENAME to $BASENAME ..."
mkdir -p $BASENAME
tar -xvf $FILENAME -C $BASENAME

SHA=$(sha1sum $BASENAME/$BASENAME.ovf|awk -F' ' {'print $1'})
echo "calculating SHA $BASENAME.ovf: $SHA"

echo "Fixing ovf definitions"
cp $BASENAME/$BASENAME.ovf $BASENAME/$BASENAME.ovf.orig

sed -i 's\<vssd:VirtualSystemType>virtualbox-2.2</vssd:VirtualSystemType>\<vssd:VirtualSystemType>vmx-07</vssd:VirtualSystemType>\g' $BASENAME/$BASENAME.ovf
sed -i 's\<rasd:Caption>sataController0</rasd:Caption>\<rasd:Caption>SCSIController</rasd:Caption>\g' $BASENAME/$BASENAME.ovf
sed -i 's\<rasd:Description>SATA Controller</rasd:Description>\<rasd:Description>SCSI Controller</rasd:Description>\g' $BASENAME/$BASENAME.ovf
sed -i 's\<rasd:ElementName>sataController0</rasd:ElementName>\<rasd:ElementName>SCSIController</rasd:ElementName>\g' $BASENAME/$BASENAME.ovf
sed -i 's\<rasd:ResourceSubType>AHCI</rasd:ResourceSubType>\<rasd:ResourceSubType>lsilogic</rasd:ResourceSubType>\g' $BASENAME/$BASENAME.ovf
sed -i 's\<rasd:ResourceType>20</rasd:ResourceType>\<rasd:ResourceType>6</rasd:ResourceType>\g' $BASENAME/$BASENAME.ovf

echo "Compressing it as $BASENAME.fixed.ova"
cd $BASENAME
tar -cf ../$BASENAME.fixed.ova *
cd ..
echo "Finished"
