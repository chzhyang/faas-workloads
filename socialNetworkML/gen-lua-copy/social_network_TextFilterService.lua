--
-- Autogenerated by Thrift
--
-- DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
-- @generated
--


require 'Thrift'
require 'social_network_ttypes'

TextFilterServiceClient = __TObject.new(__TClient, {
  __type = 'TextFilterServiceClient'
})

function TextFilterServiceClient:TextFilter(req_id, text, carrier)
  self:send_TextFilter(req_id, text, carrier)
  return self:recv_TextFilter(req_id, text, carrier)
end

function TextFilterServiceClient:send_TextFilter(req_id, text, carrier)
  self.oprot:writeMessageBegin('TextFilter', TMessageType.CALL, self._seqid)
  local args = TextFilter_args:new{}
  args.req_id = req_id
  args.text = text
  args.carrier = carrier
  args:write(self.oprot)
  self.oprot:writeMessageEnd()
  self.oprot.trans:flush()
end

function TextFilterServiceClient:recv_TextFilter(req_id, text, carrier)
  local fname, mtype, rseqid = self.iprot:readMessageBegin()
  if mtype == TMessageType.EXCEPTION then
    local x = TApplicationException:new{}
    x:read(self.iprot)
    self.iprot:readMessageEnd()
    error(x)
  end
  local result = TextFilter_result:new{}
  result:read(self.iprot)
  self.iprot:readMessageEnd()
  if result.success ~= nil then
    return result.success
  elseif result.se then
    error(result.se)
  end
  error(TApplicationException:new{errorCode = TApplicationException.MISSING_RESULT})
end
TextFilterServiceIface = __TObject:new{
  __type = 'TextFilterServiceIface'
}


TextFilterServiceProcessor = __TObject.new(__TProcessor
, {
 __type = 'TextFilterServiceProcessor'
})

function TextFilterServiceProcessor:process(iprot, oprot, server_ctx)
  local name, mtype, seqid = iprot:readMessageBegin()
  local func_name = 'process_' .. name
  if not self[func_name] or ttype(self[func_name]) ~= 'function' then
    iprot:skip(TType.STRUCT)
    iprot:readMessageEnd()
    x = TApplicationException:new{
      errorCode = TApplicationException.UNKNOWN_METHOD
    }
    oprot:writeMessageBegin(name, TMessageType.EXCEPTION, seqid)
    x:write(oprot)
    oprot:writeMessageEnd()
    oprot.trans:flush()
  else
    self[func_name](self, seqid, iprot, oprot, server_ctx)
  end
end

function TextFilterServiceProcessor:process_TextFilter(seqid, iprot, oprot, server_ctx)
  local args = TextFilter_args:new{}
  local reply_type = TMessageType.REPLY
  args:read(iprot)
  iprot:readMessageEnd()
  local result = TextFilter_result:new{}
  local status, res = pcall(self.handler.TextFilter, self.handler, args.req_id, args.text, args.carrier)
  if not status then
    reply_type = TMessageType.EXCEPTION
    result = TApplicationException:new{message = res}
  elseif ttype(res) == 'ServiceException' then
    result.se = res
  else
    result.success = res
  end
  oprot:writeMessageBegin('TextFilter', reply_type, seqid)
  result:write(oprot)
  oprot:writeMessageEnd()
  oprot.trans:flush()
end

-- HELPER FUNCTIONS AND STRUCTURES

TextFilter_args = __TObject:new{
  req_id,
  text,
  carrier
}

function TextFilter_args:read(iprot)
  iprot:readStructBegin()
  while true do
    local fname, ftype, fid = iprot:readFieldBegin()
    if ftype == TType.STOP then
      break
    elseif fid == 1 then
      if ftype == TType.I64 then
        self.req_id = iprot:readI64()
      else
        iprot:skip(ftype)
      end
    elseif fid == 2 then
      if ftype == TType.STRING then
        self.text = iprot:readString()
      else
        iprot:skip(ftype)
      end
    elseif fid == 3 then
      if ftype == TType.MAP then
        self.carrier = {}
        local _ktype47, _vtype48, _size46 = iprot:readMapBegin() 
        for _i=1,_size46 do
          local _key50 = iprot:readString()
          local _val51 = iprot:readString()
          self.carrier[_key50] = _val51
        end
        iprot:readMapEnd()
      else
        iprot:skip(ftype)
      end
    else
      iprot:skip(ftype)
    end
    iprot:readFieldEnd()
  end
  iprot:readStructEnd()
end

function TextFilter_args:write(oprot)
  oprot:writeStructBegin('TextFilter_args')
  if self.req_id ~= nil then
    oprot:writeFieldBegin('req_id', TType.I64, 1)
    oprot:writeI64(self.req_id)
    oprot:writeFieldEnd()
  end
  if self.text ~= nil then
    oprot:writeFieldBegin('text', TType.STRING, 2)
    oprot:writeString(self.text)
    oprot:writeFieldEnd()
  end
  if self.carrier ~= nil then
    oprot:writeFieldBegin('carrier', TType.MAP, 3)
    oprot:writeMapBegin(TType.STRING, TType.STRING, ttable_size(self.carrier))
    for kiter52,viter53 in pairs(self.carrier) do
      oprot:writeString(kiter52)
      oprot:writeString(viter53)
    end
    oprot:writeMapEnd()
    oprot:writeFieldEnd()
  end
  oprot:writeFieldStop()
  oprot:writeStructEnd()
end

TextFilter_result = __TObject:new{
  success,
  se
}

function TextFilter_result:read(iprot)
  iprot:readStructBegin()
  while true do
    local fname, ftype, fid = iprot:readFieldBegin()
    if ftype == TType.STOP then
      break
    elseif fid == 0 then
      if ftype == TType.BOOL then
        self.success = iprot:readBool()
      else
        iprot:skip(ftype)
      end
    elseif fid == 1 then
      if ftype == TType.STRUCT then
        self.se = ServiceException:new{}
        self.se:read(iprot)
      else
        iprot:skip(ftype)
      end
    else
      iprot:skip(ftype)
    end
    iprot:readFieldEnd()
  end
  iprot:readStructEnd()
end

function TextFilter_result:write(oprot)
  oprot:writeStructBegin('TextFilter_result')
  if self.success ~= nil then
    oprot:writeFieldBegin('success', TType.BOOL, 0)
    oprot:writeBool(self.success)
    oprot:writeFieldEnd()
  end
  if self.se ~= nil then
    oprot:writeFieldBegin('se', TType.STRUCT, 1)
    self.se:write(oprot)
    oprot:writeFieldEnd()
  end
  oprot:writeFieldStop()
  oprot:writeStructEnd()
end