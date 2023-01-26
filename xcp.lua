xcp_protocol = Proto("XCP",  "XCP Protocol")

-- XCP Header
len = ProtoField.uint8("xcp.len", "LEN", base.DEC) -- LEN
ctr = ProtoField.uint8("xcp.ctr", "CTR", base.DEC) -- CTR
-- XCP Packet
pid = ProtoField.uint8("xcp.pid", "PID", base.DEC) -- PID,
fill = ProtoField.uint8("xcp.fill", "FILL", base.DEC) -- FILL,
daq = ProtoField.uint8("xcp.daw", "DAQ", base.DEC) -- DAQ,
timestamp = ProtoField.uint8("xcp.timestamp", "TIMESTAMP", base.DEC) -- TIMESTAMP,
data = ProtoField.uint8("xcp.data", "DATA", base.DEC) -- DATA,

xcp_protocol.fields = {
    len,
    ctr,
    pid,
    fill,
    daq,
    timestamp,
    data
}

function xcp_protocol.dissector(buffer, pinfo, tree)
  length = buffer:len()
  if length == 0 then return end

  pinfo.cols.protocol = xcp_protocol.name

  local subtree = tree:add(xcp_protocol, buffer(), "XCP Protocol")
  subtree:add_le(len, buffer(0,1))
  subtree:add_le(ctr, buffer(0,1))
  subtree:add_le(pid, buffer(0,1))
  subtree:add_le(fill, buffer(0,1))
  subtree:add_le(daq, buffer(0,1))
  subtree:add_le(timestamp, buffer(0,1))
  subtree:add_le(data, buffer(0,1))

end

local udp_port = DissectorTable.get("udp.port")
udp_port:add(59274, xcp_protocol)
