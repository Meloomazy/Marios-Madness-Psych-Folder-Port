#pragma header
uniform float aberrationAmount;

    void main()
    {
        vec2 uv = openfl_TextureCoordv.xy;
        vec2 distFromCenter = uv - 0.5;

        vec2 aberrated = aberrationAmount * pow(distFromCenter, vec2(3.0, 3.0));
        
        gl_FragColor = vec4
        (
            flixel_texture2D(bitmap, uv - aberrated).r,
            flixel_texture2D(bitmap, uv).g,
            flixel_texture2D(bitmap, uv + aberrated).b,
            1.0
        );
    }