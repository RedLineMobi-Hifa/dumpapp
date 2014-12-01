git submodule update --init
ls -la
ID=dumpapp-$(date +"%Y%m%d%H%M%S")
echo "Start building image..." $ID
docker build -t index.fffee.org/$ID .
echo "Push image..."
docker push index.fffee.org/$ID 
echo "Deploy image..."
docker -H tcp://index.fffee.org:2375  run -Pd index.fffee.org/$ID 
CID=$(docker -H tcp://index.fffee.org:2375 ps -l -q)
docker -H tcp://index.fffee.org:2375 inspect $CID
