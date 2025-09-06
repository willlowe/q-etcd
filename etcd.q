.utils.b64decode:{`char$2 sv/: a where 8=count each a:8 cut raze {#[6-count[x];0],x} each 2 vs/: .Q.b6?ssr[x;"=";""]};
.qetcd.gateway:`:http://localhost:23790;
.qetcd.etcdSetUri:.Q.dd[.qetcd.gateway;`$"v3/kv/put"];
.qetcd.etcdGetUri:.Q.dd[.qetcd.gateway;`$"v3/kv/range"];
.qetcd.set:{[k;v] .Q.hp[.qetcd.etcdSetUri;.h.ty`json; "{\"key\":\"",.Q.btoa[k],"\",\"value\":\"",.Q.btoa[v],"\"}"];};
.qetcd.get:{[k].utils.b64decode last .[;`kvs`value].j.k .Q.hp[.qetcd.etcdGetUri; .h.ty`json; "{\"key\":\"",.Q.btoa[k],"\"}"]};

// .qetcd.set["Hello";"World!"]
// .qetcd.get["Hello"]
