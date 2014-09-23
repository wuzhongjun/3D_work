function display_face (shp, tex, tl, rp)
	
	shp = reshape(shp, [ 3 prod(size(shp))/3 ])'; %R n*3
	tex = reshape(tex, [ 3 prod(size(tex))/3 ])'; %R n*3
	tex = min(tex, 255);


 	set(gcf, 'Renderer', 'opengl');%set mode opengl
 	fig_pos = get(gcf, 'Position');
%  	fig_pos(3) = rp.width;
%  	fig_pos(4) = rp.height;
% 	set(gcf, 'Position', fig_pos);
% 	set(gcf, 'ResizeFcn', @resizeCallback);

	mesh_h = trimesh(...
		tl, shp(:, 1),  shp(:, 3),shp(:, 2), ...
		'EdgeColor', 'none', ...
		'FaceVertexCData', tex/255, 'FaceColor', 'interp', ...
		'FaceLighting', 'phong' ...
	);

	set(gca, ...
		'DataAspectRatio', [ 1 1 1 ], ...
		'PlotBoxAspectRatio', [ 1 1 1 ], ...
		'Units', 'pixels', ...
		'GridLineStyle', 'none', ...
		'Position', [ 0 0 fig_pos(3) fig_pos(4) ], ...
		'Visible', 'off', 'box', 'off', ...
		'Projection', 'perspective' ...
		); 
	
	set(gcf, 'Color', [ 0 0 0 ]); 
	view(180 + rp.phi * 180 / pi, 0);
   % view(180,0);
   % zdir=[0 0 1];
   % rotate(mesh_h,zdir,-25);
   %view(0,90);
	%material([.5, .5, .1 1  ])
    material([1, 1, .175 30  ])
% 	camlight('headlight');

%% pm00006 18Feb11: Note on handling Illumination
% Once the surface has been drawn, the hierarchy of the graphic objects is:
% root_object(0) -> figure -> axes|-> light
%                                 |-> patch
% where PATCH is a patch object containing the rendered surface and 
% LIGHT is a light object handling directional illumination of the scene.
%     * The handle of the root object is (0)
%     * The handle for the figure can be obtained by 'gcf'
%     * The handle for the axes can be obtained by either 'gca' or get(gcf,'Children')
%     * the handles for the light and patch objects can be obtained by get(gca,'Children')
% Note that you can add more directional lights by using the command 'light'. 
% These extra lights will be added as further children of the axes.
% 
% Ambient lighting:
% The AXES object has a property called 'AmbientLightColor' which is a 1x3 
% vector which defines the color of the ambient light illuminating the whole scene.
% default value is [1 1 1].Modify this property to change the color of ambient light.
% Example: The following, turns the ambient light off: 
% set(gca, 'AmbientLightColor', [0 0 0] ); 
% Note: This actually sets the color of light to black!
% 
% Directional lighting:
% A dedicated 'light' object controls the properties of the directional light illuminating the scene.
% See 'Light Properties' for help. Change these properties to modify the directional light.
% 
% See 'Patch Properties' for how to handle contributions of specular and diffuse light etc.


%% ------------------------------------------------------------CALLBACK--------
function resizeCallback (obj, eventdata)
	
	fig = gcbf;
	fig_pos = get(fig, 'Position');

	axis = findobj(get(fig, 'Children'), 'Tag', 'Axis.Head');
	set(axis, 'Position', [ 0 0 fig_pos(3) fig_pos(4) ]);
	
