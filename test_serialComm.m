% %%
% arduinoSerial_pressure  = serial('COM6');
% arduinoSerial_pressure.BaudRate = 115200;
% fopen(arduinoSerial_pressure);
% 
% tic;
% data = [0,0,0];
% t = 0;
% n = 0;
% while n < 5001
%     %t(length(t)+1) = toc;
%     if n == 0
%         fprintf(arduinoSerial_pressure,mat2str([1,0,200]));
%         t = [t toc];
%     end
%     if n == 1000
%         fprintf(arduinoSerial_pressure,mat2str([2,1,200]));
%         t = [t toc];
%     end
%     if n == 2000
%         fprintf(arduinoSerial_pressure,mat2str([3,0,200]));
%         t = [t toc];
%     end
%     if n == 3000
%         fprintf(arduinoSerial_pressure,mat2str([4,1,200]));
%         t = [t toc];
%     end
%     if n == 4000
%         fprintf(arduinoSerial_pressure,mat2str([5,0,200]));
%         t = [t toc];
%     end
%     if n == 5000
%         fprintf(arduinoSerial_pressure,mat2str([6,1,200]));
%         t = [t toc];
%     end
%     n = n+1;
% %     current_data = str2num(fscanf(arduinoSerial_pressure));
% %     data(length(data(:,1))+1,:) = current_data; 
% end
% current_data = str2num(fscanf(arduinoSerial_pressure));
% data(length(data(:,1))+1,:) = current_data; 
% 
% fclose(arduinoSerial_pressure);
% 
% Esto es para ver si se han mandado los datos correctamente
% arduinoSerial_pressure.BytesAvailable
% 
% Cuando se mandan los datos correctamente, el arduino devuelve un 1, se 
% supone que esa variable debe ser 1. Para devolver esa variable a 0 lo que
% hay que hacer es cerrar el puerto. En otras palabras, hay que hacer esto:
% 
% - abrir puerto
% - mandar datos
% - si se ha recibido un 1 en BytesAvailable, perfe,
% si no, volver a mandar datos
% OJO con poner un while, xq se le están mandando los datos sin parar
% Igual lo que hay q hacer es que el 1 lo mande nada mas que entre en el 
% SerialEvent, en lugar de cuando acabe el bucle for...
% - Una vez de han mandado los datos, hacer fclose.
% Esto así está bien? O si hay q volver a abrir el puerto se va el tema del
% movimiento continuo a la mierda? Sería mejor poner un pequeño delay después
% de mandar los datos para asegurarnos de que lleguen correctamente siempre y 
% luego una pequeña comprobación y fuera?



%%
clear
arduinoSerial_stepper  = serial('COM3');
arduinoSerial_stepper.BaudRate = 115200;
fopen(arduinoSerial_stepper);

tic;
data = [];
t = 0;
n = 1;
while n<3500
    current_data = str2double(fscanf(arduinoSerial_stepper));
    data(n) = current_data;
    
    if n== 500
        fprintf(arduinoSerial_stepper,mat2str([439, 1, 50]));
    end
    
    if n == 5500
        fprintf(arduinoSerial_stepper,mat2str([500, 0, 50]));
    end        
    
    n = n+1;
end

fclose(arduinoSerial_stepper);





