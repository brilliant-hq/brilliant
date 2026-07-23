# WebGL Shader Runtime

Minimal JS runtime for Brilliant shaders in exported HTML. Paste into a `<script>` tag, then call `brilliantShader()` for procedural fills or `brilliantFilter()` for image filters.

## Runtime Code

```javascript
const _V=`#version 300 es\nin vec2 a;void main(){gl_Position=vec4(a,0,1);}`;
function _gl(c){const g=c.getContext('webgl2',{alpha:true,premultipliedAlpha:true});if(!g)throw new Error('WebGL2 required');const b=g.createBuffer();g.bindBuffer(g.ARRAY_BUFFER,b);g.bufferData(g.ARRAY_BUFFER,new Float32Array([-1,-1,1,-1,-1,1,1,1]),g.STATIC_DRAW);return g;}
function _sh(g,s,t){const o=g.createShader(t);g.shaderSource(o,s);g.compileShader(o);if(!g.getShaderParameter(o,g.COMPILE_STATUS))throw new Error(g.getShaderInfoLog(o));return o;}
function _pg(g,f){const p=g.createProgram();g.attachShader(p,_sh(g,_V,g.VERTEX_SHADER));g.attachShader(p,_sh(g,f,g.FRAGMENT_SHADER));g.bindAttribLocation(p,0,'a');g.linkProgram(p);if(!g.getProgramParameter(p,g.LINK_STATUS))throw new Error(g.getProgramInfoLog(p));g.useProgram(p);g.enableVertexAttribArray(0);g.vertexAttribPointer(0,2,g.FLOAT,false,0,0);return p;}
function _ul(g,p){const u={},n=g.getProgramParameter(p,g.ACTIVE_UNIFORMS);for(let i=0;i<n;i++){const info=g.getActiveUniform(p,i);u[info.name]=g.getUniformLocation(p,info.name);}return u;}
function _hex(h){h=h.replace('#','');if(h.length===3)h=h[0]+h[0]+h[1]+h[1]+h[2]+h[2];const r=parseInt(h.substr(0,2),16)/255,g=parseInt(h.substr(2,2),16)/255,b=parseInt(h.substr(4,2),16)/255,a=h.length>=8?parseInt(h.substr(6,2),16)/255:1;return[r,g,b,a];}

function brilliantShader(canvas, fragSrc, cfg={}) {
  if (typeof canvas==='string') canvas=document.getElementById(canvas);
  const gl=_gl(canvas), prog=_pg(gl,fragSrc), u=_ul(gl,prog);
  const colors=(cfg.colors||['#000','#fff']).map(_hex);
  const params=Object.assign({},cfg.params||{});
  const shape=cfg.shape==='circle'?1:0;
  const cr=cfg.cornerRadius||[0,0,0,0];
  const uvS=cfg.scale??1, uvOX=cfg.offsetX??0, uvOY=cfg.offsetY??0;
  const uvR=(cfg.rotation??0)*Math.PI/180;
  let anim=cfg.animate!==false, t0=performance.now()/1000, tp=0, raf=null;

  // Fallback 1x1 texture for unused samplers
  const ft=gl.createTexture();gl.bindTexture(gl.TEXTURE_2D,ft);
  gl.texImage2D(gl.TEXTURE_2D,0,gl.RGBA,1,1,0,gl.RGBA,gl.UNSIGNED_BYTE,new Uint8Array([0,0,0,255]));
  for(const[name,unit]of[['uSDFTexture',0],['uEdgeData',1]]){
    if(u[name]!=null){gl.activeTexture(gl.TEXTURE0+unit);gl.bindTexture(gl.TEXTURE_2D,ft);gl.uniform1i(u[name],unit);}
  }

  // Mouse tracking (for interactive shaders like reactive_grid)
  let mx=0,my=0,ma=0,md=0;
  if(cfg.interactive){
    canvas.addEventListener('mousemove',e=>{const r=canvas.getBoundingClientRect();mx=(e.clientX-r.left)/r.width;my=(e.clientY-r.top)/r.height;ma=1;});
    canvas.addEventListener('mouseleave',()=>{ma=0;});
    canvas.addEventListener('mousedown',()=>{md=1;});
    canvas.addEventListener('mouseup',()=>{md=0;});
  }

  function resize(){const r=canvas.getBoundingClientRect(),d=devicePixelRatio||1;canvas.width=r.width*d;canvas.height=r.height*d;gl.viewport(0,0,canvas.width,canvas.height);}
  const ro=new ResizeObserver(resize);ro.observe(canvas);resize();

  function render(now){
    const t=anim?(now/1000-t0):tp, w=canvas.width, h=canvas.height;
    gl.clearColor(0,0,0,0);gl.clear(gl.COLOR_BUFFER_BIT);
    // Standard uniforms
    const S=[[u.uResolutionX,w],[u.uResolutionY,h],[u.uTime,t],[u.uOffsetX,0],[u.uOffsetY,0],
      [u.uScale,uvS],[u.uUVOffsetX,uvOX],[u.uUVOffsetY,uvOY],[u.uRotation,uvR],
      [u.uShapeType,shape],[u.uCornerTL,cr[0]],[u.uCornerTR,cr[1]],[u.uCornerBL,cr[2]],[u.uCornerBR,cr[3]],
      [u.uRefAspect,cfg.refAspect??(w/h)],[u.uColorCount,colors.length]];
    for(const[loc,val]of S)if(loc!=null)gl.uniform1f(loc,val);
    // Colors
    for(let i=0;i<5;i++){const c=colors[i]||[0,0,0,1];if(u['uColor'+i]!=null)gl.uniform4f(u['uColor'+i],c[0],c[1],c[2],c[3]);}
    // Params
    for(const[k,v]of Object.entries(params))if(u[k]!=null)gl.uniform1f(u[k],v);
    // Mouse
    if(cfg.interactive){
      if(u.uMouseActive!=null)gl.uniform1f(u.uMouseActive,ma);
      if(u.uMouseX!=null)gl.uniform1f(u.uMouseX,mx);
      if(u.uMouseY!=null)gl.uniform1f(u.uMouseY,my);
      if(u.uMouseDown!=null)gl.uniform1f(u.uMouseDown,md);
    }
    gl.drawArrays(gl.TRIANGLE_STRIP,0,4);
    raf=requestAnimationFrame(render);
  }
  raf=requestAnimationFrame(render);

  return{
    play(){if(!anim){t0=performance.now()/1000-tp;anim=true;}},
    pause(){if(anim){tp=performance.now()/1000-t0;anim=false;}},
    setParam(k,v){params[k]=v;},
    setColors(c){colors.length=0;c.forEach(h=>colors.push(_hex(h)));},
    destroy(){cancelAnimationFrame(raf);ro.disconnect();gl.getExtension('WEBGL_lose_context')?.loseContext();}
  };
}

function brilliantFilter(canvas, sourceEl, fragSrc, cfg={}) {
  if(typeof canvas==='string')canvas=document.getElementById(canvas);
  if(typeof sourceEl==='string')sourceEl=document.getElementById(sourceEl);
  const gl=_gl(canvas), prog=_pg(gl,fragSrc), u=_ul(gl,prog);
  const params=Object.assign({},cfg.params||{});

  const tex=gl.createTexture();gl.activeTexture(gl.TEXTURE0);gl.bindTexture(gl.TEXTURE_2D,tex);
  gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_WRAP_S,gl.CLAMP_TO_EDGE);
  gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_WRAP_T,gl.CLAMP_TO_EDGE);
  gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_MIN_FILTER,gl.LINEAR);
  gl.texParameteri(gl.TEXTURE_2D,gl.TEXTURE_MAG_FILTER,gl.LINEAR);

  function resize(){const r=canvas.getBoundingClientRect(),d=devicePixelRatio||1;canvas.width=r.width*d;canvas.height=r.height*d;gl.viewport(0,0,canvas.width,canvas.height);}
  const ro=new ResizeObserver(resize);ro.observe(canvas);resize();

  function render(){
    gl.activeTexture(gl.TEXTURE0);gl.bindTexture(gl.TEXTURE_2D,tex);
    gl.texImage2D(gl.TEXTURE_2D,0,gl.RGBA,gl.RGBA,gl.UNSIGNED_BYTE,sourceEl);
    const w=canvas.width,h=canvas.height;
    gl.clearColor(0,0,0,0);gl.clear(gl.COLOR_BUFFER_BIT);
    if(u.uResolutionX!=null)gl.uniform1f(u.uResolutionX,w);
    if(u.uResolutionY!=null)gl.uniform1f(u.uResolutionY,h);
    if(u.uScale!=null)gl.uniform1f(u.uScale,devicePixelRatio||1);
    if(u.uInputImage!=null)gl.uniform1i(u.uInputImage,0);
    for(const[k,v]of Object.entries(params))if(u[k]!=null)gl.uniform1f(u[k],v);
    gl.drawArrays(gl.TRIANGLE_STRIP,0,4);
  }

  if(sourceEl instanceof HTMLCanvasElement||sourceEl.complete||sourceEl.readyState>=2)render();
  else sourceEl.addEventListener('load',render,{once:true});

  return{
    update(){render();},
    setParam(k,v){params[k]=v;render();},
    destroy(){ro.disconnect();gl.getExtension('WEBGL_lose_context')?.loseContext();}
  };
}
```

## API Reference

### `brilliantShader(canvas, fragSrc, config)`: Procedural shader fills

| Config Key | Type | Default | Description |
|------------|------|---------|-------------|
| `colors` | `string[]` | `['#000','#fff']` | Hex color palette |
| `params` | `object` | `{}` | Shader-specific uniforms (e.g. `{uCount:15, uSize:0.3}`) |
| `shape` | `string` | `'rect'` | `'rect'` or `'circle'` |
| `cornerRadius` | `number[4]` | `[0,0,0,0]` | Normalized corner radii `[TL,TR,BL,BR]` (0-1) |
| `scale` | `number` | `1.0` | UV pattern scale |
| `offsetX` | `number` | `0` | UV pattern offset X |
| `offsetY` | `number` | `0` | UV pattern offset Y |
| `rotation` | `number` | `0` | UV pattern rotation (degrees) |
| `refAspect` | `number` | auto | Reference aspect ratio (auto = canvas aspect) |
| `animate` | `boolean` | `true` | Start animating |
| `interactive` | `boolean` | `false` | Enable mouse tracking (for reactive_grid) |

**Returns:** `{ play(), pause(), setParam(name, value), setColors(hexArray), destroy() }`

### `brilliantFilter(canvas, sourceEl, fragSrc, config)`: Image filters

| Config Key | Type | Default | Description |
|------------|------|---------|-------------|
| `params` | `object` | `{}` | Filter-specific uniforms |

- `canvas`: Canvas element or ID string
- `sourceEl`: Source image/canvas element or ID string

**Returns:** `{ update(), setParam(name, value), destroy() }`

## GLSL Conversion Notes

All Brilliant shaders are ported from SkSL (Flutter GLSL 460) to GLSL ES 3.0 (WebGL 2). Changes:

1. `#version 300 es` + `precision highp float;` header
2. `FlutterFragCoord()` replaced with `vec4(gl_FragCoord.x, uResolutionY - gl_FragCoord.y, 0, 0)` (Y-flip for top-left origin)
3. `layout(location=N)` removed from uniforms (WebGL binds by name)
4. `uniform sampler2D uSDFTexture/uEdgeData` removed (web uses rect/circle shapes only)
5. `elementSDF()` simplified to rect + circle analytical paths (no vector SDF textures)
6. Shader body logic is **identical** to the Flutter version
