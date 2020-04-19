class ItemsController < ApplicationController

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
