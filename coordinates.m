function [px,py]=coordinates(COOR)

px(1)=COOR(1,1);
q=2;
for i=2:size(COOR,1)
    
    if COOR(i,1)~=px(q-1)
        px(q)=COOR(i,1);
        q=q+1;
    end
    
end

py(1)=COOR(1,2);
q=2;
for i=2:size(COOR,1)
    
    if (COOR(i,2)~=py(q-1))
        py(q)=COOR(i,2);
        q=q+1;
    end
    
end
