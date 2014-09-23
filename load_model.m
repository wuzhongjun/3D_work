function [model msz] = load_model()
  global model;
  if isempty(model);
    model = load('../01_MorphableModel.mat');
  end
  msz.n_shape_dim = size(model.shapePC, 2);  %shapePC 160470*199 n_shape_dim=199 
  msz.n_tex_dim   = size(model.texPC,   2);  %texPC 160470*199 n_tex_dim=199
  msz.n_seg       = size(model.segbin,  2);  %segbin 53490*4 n_seg=4
end  