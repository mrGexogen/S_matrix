function [] = update_G2( hObject,handles,i,j,is_real,text_label  )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

val = get(hObject,'Value');

set(findobj('Tag',text_label), 'String', val);

if is_real
    handles.S(i,j) = re_change(handles.S(i,j), val);
else
    handles.S(i,j) = im_change(handles.S(i,j), val);
end

handles.G2 = restore_G2(handles.G1, handles.S);
set(handles.plot_G2, 'XData', real(handles.G2), 'YData', imag(handles.G2));

[x, y] = extract_coords(handles.G2, handles.lth);

for i = 1:length(handles.text_G2)
    set(handles.text_G2(i), 'Position', [x(i) y(i)]);
end
set(handles.labels_G2, 'XData', x, 'YData', y);

phi2 = unwrap(angle(handles.G2));
set(handles.plot_phi2, 'YData', phi2);

du2 = diff(phi2);
set(handles.plot_du2, 'YData', du2);

set(handles.plot_X2, 'YData', real(handles.G2));
set(handles.plot_Y2, 'YData', imag(handles.G2));

X = real(handles.G2);
Y = imag(handles.G2);
absG2 = abs(handles.G2);

corrX = xcorr(X, du2, 'none');
corrY = xcorr(Y, du2, 'none');
corrAbs = xcorr(absG2, du2, 'none');

set(handles.plot_xcorrX, 'YData', corrX);
set(handles.plot_xcorrY, 'YData', corrY);
set(handles.plot_xcorrAbs, 'YData', corrAbs);

set(handles.plot_absG2, 'YData', abs(handles.G2));

guidata(hObject, handles);
end

