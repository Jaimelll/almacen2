class ItemsController < ApplicationController

  def jalar(vruc,vpara)
    if vruc and vruc.length==11 then
      require 'json'
      require 'open-uri'
     # vruta='https://ww1.essalud.gob.pe/sisep/postulante/postulante/postulante_obtenerDatosPostulante.htm?strDni='+vadni
     vruta='https://api.sunat.cloud/ruc/'+vruc
      
      value0= nil   
      begin 
      value0 = JSON.parse(open(vruta).read)
      rescue JSON::ParserError
        false
        Item.where(id:vpara).update_all( razon2:"no encuentra ruc",client_id:881)
      end
      value1 =value0
      puts value1
      if value1 then
       Item.where(id:vpara).update_all( razon2:value1["razon_social"])

       if Client.where(ruc:vruc).count==0  then
         
        object = Client.new(:ruc => vruc,
                            :razon=> value1["razon_social"],
                            :direccion => value1["domicilio_fiscal"],
                            :user_id => 3)


          object.save

        end
        vidclient=Client.where(ruc:vruc).select('id as dd').first.dd
        Item.where(id:vpara).update_all(client_id:vidclient)


      end
    else
      Item.where(id:vpara).update_all( razon2:"no encuentra ruc",client_id:881)
    end       
  end#def jalar
  

  def nuevos
    compro = ItemsController.new
     
    
    

     Item.where(nuevo:1).update_all( origen:Parameter.find_by_id(1).origen, 
                                     mmes:Parameter.find_by_id(1).mes,
                                     empresa:Parameter.find_by_id(1).empresa)

    
  Item.where(nuevo:1).each do |ittem| 
    Item.where(id:ittem.id).update_all(subtotal:ittem.monto/1.18)

     object = Detail.new(:descripcion => ittem.detalle,
                         :cantidad=> 1,
                         :item_id => ittem.id,
                         :precio => ittem.monto/1.18,
                         :monto =>ittem.monto,
                         :user_id => 3)

    
     
     object.save
     
     compro.jalar( ittem.ruc,ittem.id)
     
    end

     
     Item.where(nuevo:1).update_all( nuevo:0)                                
  


  end




    def centr_nomb(idclient)
        vrazon='sin razon '
        vruc='sin ruc '
      if Client.where(id:idclient).count>0 then
      vrazon= Client.find_by_id(idclient).razon
      vruc=   Client.find_by_id(idclient).ruc
      end 
       return vrazon,vruc
     end
    
     def nota_credito(viditem)
           vid=0
  

           Item.where(id:viditem).each do |item|
            if item.sele1==4 then
              nid=Item.where(serie:item.serie,nfactu:item.nfactu,client_id:item.client_id).
              where(origen:item.origen).where.not(id:viditem)
              if nid.count>0 then
                # existe Nota de credito 4
                vid=nid.select('id as dd').first.dd
              end 
             end 
           end #  de each

          if vid>0 then
            Detail.where(item_id:viditem).destroy_all
            Detail.where(item_id:vid).each do |deta|
              object = Detail.new(:item_id => viditem,
               :product_id => deta.product_id,:descripcion=> deta.descripcion,
               :cantidad => deta.cantidad,:precio => deta.precio,
               :monto =>deta.monto, :user_id => 1,
               :created_at => Time.now,
               :updated_at => Time.now, )

               object.save
            

            end
        
          end


      end # de la funcion  nota de credito

   
end
